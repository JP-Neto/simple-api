import boto3
import os

def lambda_handler(event, context):
    ecs = boto3.client('ecs')
    sns = boto3.client('sns')
    
    
    topic_arn = os.environ.get('SNS_TOPIC_ARN')
    
    repo_name = event['detail']['repository-name']
    image_tag = event['detail']['image-tag']
    
    print(f"Novo push detectado no repo {repo_name} com a tag {image_tag}")
    
    cluster_name = "ecs-api-xpto"
    service_name = "simple-api-task-service"
    
    try:
       
        ecs.update_service(
            cluster=cluster_name,
            service=service_name,
            forceNewDeployment=True
        )
        
        
        message = f"🚀 Deploy Iniciado!\n\nRepositório: {repo_name}\nTag: {image_tag}\nCluster: {cluster_name}\n\nO ECS está provisionando as novas Tasks."
        
        sns.publish(
            TopicArn=topic_arn,
            Message=message,
            Subject=f"✅ Deploy {repo_name} - Sucesso"
        )
        
        return {
            'statusCode': 200,
            'body': f"Deploy disparado e notificado para a tag {image_tag}"
        }
        
    except Exception as e:
        error_msg = f"❌ Erro no deploy para {repo_name}: {str(e)}"
        print(error_msg)        
        
        sns.publish(
            TopicArn=topic_arn,
            Message=error_msg,
            Subject="🚨 Falha no Deploy"
        )
        raise e