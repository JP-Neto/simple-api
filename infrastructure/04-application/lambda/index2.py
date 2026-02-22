import boto3
import os

def lambda_handler(event, context):
    ecs = boto3.client('ecs')
    sns = boto3.client('sns')
    
    topic_arn = os.environ.get('SNS_TOPIC_ARN')
    repo_name = event['detail']['repository-name']
    image_tag = event['detail']['image-tag']
    
    new_image_uri = f"{event['detail']['repository-name']}:{image_tag}"
    if 'account' in event:
         account_id = event['account']
         region = event['region']
         new_image_uri = f"{account_id}.dkr.ecr.{region}.amazonaws.com/{repo_name}:{image_tag}"

    cluster_name = "ecs-api-xpto"
    service_name = "simple-api-task-service"

    try:
        
        service_info = ecs.describe_services(cluster=cluster_name, services=[service_name])
        current_task_def_arn = service_info['services'][0]['taskDefinition']
        
        task_def = ecs.describe_task_definition(taskDefinition=current_task_def_arn)['taskDefinition']

       
        task_def['containerDefinitions'][0]['image'] = new_image_uri
        
       
        for field in ['taskDefinitionArn', 'revision', 'status', 'requiresAttributes', 'compatibilities', 'registeredAt', 'registeredBy']:
            task_def.pop(field, None)

        new_task_def = ecs.register_task_definition(**task_def)
        new_task_def_arn = new_task_def['taskDefinition']['taskDefinitionArn']

        
        ecs.update_service(
            cluster=cluster_name,
            service=service_name,
            taskDefinition=new_task_def_arn,
            forceNewDeployment=True
        )

       
        message = f"🚀 CD Finalizado com Sucesso!\n\nRepo: {repo_name}\nNova Tag: {image_tag}\nNova Task Def: {new_task_def_arn}"
        sns.publish(TopicArn=topic_arn, Message=message, Subject="✅ Task Simple API - Updated")

        return {'statusCode': 200, 'body': 'Task Definition atualizada e Service reiniciado.'}

    except Exception as e:
        error_msg = f"❌ Falha no Deploy para {repo_name}: {str(e)}"
        sns.publish(TopicArn=topic_arn, Message=error_msg, Subject="🚨 Erro no CD")
        raise e