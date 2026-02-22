import boto3
import os

def lambda_handler(event, context):
    ecs = boto3.client('ecs')
    sns = boto3.client('sns')
    
    topic_arn = os.environ.get('SNS_TOPIC_ARN')
    
    try:
        
        detail = event.get('detail', {})
        request_params = detail.get('requestParameters', {})
        
        
        repo_name = request_params.get('repositoryName')
        image_tag = request_params.get('imageTag')
        
        
        account_id = event.get('account')
        region = event.get('region')
        
        if not repo_name or not image_tag:
            raise ValueError(f"Dados incompletos no evento. Repo: {repo_name}, Tag: {image_tag}")

        new_image_uri = f"{account_id}.dkr.ecr.{region}.amazonaws.com/{repo_name}:{image_tag}"
        
        print(f"🚀 Iniciando CD para o repo {repo_name} com a tag {image_tag}")

        cluster_name = "ecs-api-xpto"
        service_name = "simple-api-task-service"

        # 1. PEGAR A TASK DEFINITION ATUAL
        service_info = ecs.describe_services(cluster=cluster_name, services=[service_name])
        current_task_def_arn = service_info['services'][0]['taskDefinition']
        
        task_def = ecs.describe_task_definition(taskDefinition=current_task_def_arn)['taskDefinition']

        # 2. CRIAR NOVA REVISÃO COM A NOVA IMAGEM
        task_def['containerDefinitions'][0]['image'] = new_image_uri
        
        # Limpeza de campos não aceitos no registro
        for field in ['taskDefinitionArn', 'revision', 'status', 'requiresAttributes', 'compatibilities', 'registeredAt', 'registeredBy']:
            task_def.pop(field, None)

        new_task_def = ecs.register_task_definition(**task_def)
        new_task_def_arn = new_task_def['taskDefinition']['taskDefinitionArn']

        # 3. ATUALIZAR O SERVIÇO ECS
        ecs.update_service(
            cluster=cluster_name,
            service=service_name,
            taskDefinition=new_task_def_arn,
            forceNewDeployment=True
        )

        # NOTIFICAÇÃO DE SUCESSO
        message = f"🚀 Deploy Finalizado !\n\nRepo: {repo_name}\nTag: {image_tag}\nNova Task Def: {new_task_def_arn}"
        sns.publish(TopicArn=topic_arn, Message=message, Subject=f"✅ CD {repo_name} - Sucesso")

        return {'statusCode': 200, 'body': f'Deploy da tag {image_tag} concluído.'}

    except Exception as e:
        error_msg = f"❌ Falha no Deploy: {str(e)}"
        print(error_msg)
        if topic_arn:
            sns.publish(TopicArn=topic_arn, Message=error_msg, Subject="🚨 Falha no Deploy")
        raise e