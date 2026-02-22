import boto3
import os

ecs = boto3.client('ecs')
sns = boto3.client('sns')

CLUSTER_NAME = "ecs-api-xpto"
SERVICE_NAME = "simple-api-task-service"
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")


def lambda_handler(event, context):
    try:
        print("📦 Evento recebido:", event)

        # =============================
        # 1️⃣ Validar evento ECR PUSH
        # =============================
        if event.get("source") != "aws.ecr":
            raise ValueError("Evento não é do ECR")

        if event.get("detail-type") != "ECR Image Action":
            raise ValueError("detail-type inválido")

        detail = event.get("detail", {})

        if detail.get("action-type") != "PUSH":
            print("Evento não é PUSH. Ignorando.")
            return {"statusCode": 200, "body": "Evento ignorado."}

        if detail.get("result") != "SUCCESS":
            print("Push não foi SUCCESS. Ignorando.")
            return {"statusCode": 200, "body": "Evento ignorado."}

        repo_name = detail.get("repository-name")
        image_tag = detail.get("image-tag")

        # Caso venha lista
        if isinstance(image_tag, list):
            image_tag = image_tag[0]

        account_id = event.get("account")
        region = event.get("region")

        if not repo_name or not image_tag:
            raise ValueError(f"Dados incompletos no evento. Repo: {repo_name}, Tag: {image_tag}")

        new_image_uri = f"{account_id}.dkr.ecr.{region}.amazonaws.com/{repo_name}:{image_tag}"

        print(f"🚀 Iniciando CD para repo {repo_name} com tag {image_tag}")
        print(f"Nova imagem: {new_image_uri}")

        # =============================
        # 2️⃣ Buscar Task Definition atual
        # =============================
        service_info = ecs.describe_services(
            cluster=CLUSTER_NAME,
            services=[SERVICE_NAME]
        )

        if not service_info["services"]:
            raise ValueError("Serviço ECS não encontrado.")

        current_task_def_arn = service_info["services"][0]["taskDefinition"]

        task_def_response = ecs.describe_task_definition(
            taskDefinition=current_task_def_arn
        )

        task_def = task_def_response["taskDefinition"]

        # =============================
        # 3️⃣ Atualizar imagem
        # =============================
        task_def["containerDefinitions"][0]["image"] = new_image_uri

        # Remover campos não aceitos
        for field in [
            "taskDefinitionArn",
            "revision",
            "status",
            "requiresAttributes",
            "compatibilities",
            "registeredAt",
            "registeredBy"
        ]:
            task_def.pop(field, None)

        # =============================
        # 4️⃣ Registrar nova revisão
        # =============================
        new_task_def = ecs.register_task_definition(**task_def)
        new_task_def_arn = new_task_def["taskDefinition"]["taskDefinitionArn"]

        print(f"Nova Task Definition registrada: {new_task_def_arn}")

        # =============================
        # 5️⃣ Atualizar serviço
        # =============================
        ecs.update_service(
            cluster=CLUSTER_NAME,
            service=SERVICE_NAME,
            taskDefinition=new_task_def_arn,
            forceNewDeployment=True
        )

        print("✅ Serviço atualizado com sucesso.")

      
        if SNS_TOPIC_ARN:
            message = (
                f"🚀 Deploy Finalizado!\n\n"
                f"Repo: {repo_name}\n"
                f"Tag: {image_tag}\n"
                f"Nova Task Def: {new_task_def_arn}"
            )

            sns.publish(
                TopicArn=SNS_TOPIC_ARN,
                Message=message,
                Subject=f"✅ Deploy {repo_name} - Sucesso"
            )

        return {
            "statusCode": 200,
            "body": f"Deploy da tag {image_tag} concluído."
        }

    except Exception as e:
        error_msg = f"❌ Falha no Deploy: {str(e)}"
        print(error_msg)

        if SNS_TOPIC_ARN:
            sns.publish(
                TopicArn=SNS_TOPIC_ARN,
                Message=error_msg,
                Subject="🚨 Falha no Deploy"
            )

        raise