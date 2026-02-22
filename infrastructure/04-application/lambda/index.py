import boto3
import os

def lambda_handler(event, context):
    cd = boto3.client('codedeploy')
    
    image_tag = event['detail']['image-tag']
    repo_name = event['detail']['repository-name']
    
    try:
        
        cd.create_deployment(
            applicationName='app-api-xpto',
            deploymentGroupName='dg-api-xpto',
            deploymentConfigName='CodeDeployDefault.ECSAllAtOnce',
            description=f'Deploy via ECR push: {image_tag}',
            revision={
                'revisionType': 'AppSpecContent',
                'appSpecContent': {
                    'content': '{"version":1,"Resources":[{"TargetService":{"Type":"AWS::ECS::Service","Properties":{"TaskDefinition":"<TASK_DEF_ARN>","LoadBalancerInfo":{"ContainerName":"simple-api-container","ContainerPort":3000}}}}]}'
                }
            }
        )
        return {'status': 'Dispatched'}
    except Exception as e:
        print(f"Erro ao disparar: {str(e)}")
        raise e