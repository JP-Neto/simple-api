############################
# ECS
############################

variable "cluster_name_api_xpto" {
  description = "Nome do cluster ECS onde os serviços da API XPTO serão executados."
  type        = string
}

variable "namespace_api_xpto" {
  description = "Nome do namespace Service Discovery utilizado pelo ECS (Cloud Map)."
  type        = string
}

variable "insights_api_xpto" {
  description = "Habilita ou desabilita o Container Insights no cluster ECS."
  type        = bool
}

variable "capacity_api_xpto" {
  description = "Lista de capacity providers associados ao cluster (ex: FARGATE, FARGATE_SPOT)."
  type        = list(string)
}

variable "tags_api_xpto" {
  description = "Mapa de tags adicionais aplicadas aos recursos do ECS."
  type        = map(string)
}

############################
# ALB
############################

variable "api_jpn_name" {
  description = "Nome do Application Load Balancer da API XPTO."
  type        = string
}

variable "alb_internal" {
  description = "Define se o ALB será interno (true) ou internet-facing (false)."
  type        = bool
}

variable "alb_type" {
  description = "Tipo do Load Balancer (ex: application)."
  type        = string
}

variable "alb_deletion_protection" {
  description = "Habilita ou desabilita a proteção contra exclusão do ALB."
  type        = bool
}

variable "access_logs_bucket" {
  description = "Nome do bucket S3 onde os logs de acesso do ALB serão armazenados."
  type        = string
}

variable "access_logs_prefix" {
  description = "Prefixo utilizado para armazenar os logs de acesso no bucket S3."
  type        = string
}

variable "access_logs_enabled" {
  description = "Define se o access log do ALB estará habilitado."
  type        = bool
}

variable "alb_api_jpn_tags" {
  description = "Mapa de tags aplicadas ao ALB."
  type        = map(string)
}

############################
# Target Group
############################

variable "tg_api_jpn_name" {
  description = "Nome do Target Group associado ao ALB para a API XPTO."
  type        = string
}

variable "tg_api_jpn_port" {
  description = "Porta que o Target Group utilizará para encaminhar tráfego aos serviços ECS."
  type        = number
}

variable "tg_api_jpn_protocol" {
  description = "Protocolo utilizado pelo Target Group (ex: HTTP)."
  type        = string
}

variable "tg_api_jpn_protocol_version" {
  description = "Versão do protocolo do Target Group (ex: HTTP1, HTTP2, GRPC)."
  type        = string
}

variable "tg_api_jpn_tags" {
  description = "Mapa de tags aplicadas ao Target Group."
  type        = map(string)
}

############################
# Listeners
############################

variable "listener_http_port" {
  description = "Porta do listener HTTP do ALB (normalmente 80)."
  type        = number
}

variable "listener_http_protocol" {
  description = "Protocolo do listener HTTP (normalmente HTTP)."
  type        = string
}

variable "listener_https_port" {
  description = "Porta do listener HTTPS do ALB (normalmente 443)."
  type        = number
}

variable "listener_https_protocol" {
  description = "Protocolo do listener HTTPS (normalmente HTTPS)."
  type        = string
}

variable "listener_certificate_arn" {
  description = "ARN do certificado ACM utilizado no listener HTTPS."
  type        = string
}

############################
# SSM TYPES MAP
############################

variable "ssm_type" {
  description = "Mapa com os tipos suportados pelo SSM Parameter Store."
  type        = map(string)
}

############################
# API_PORT
############################

variable "name_ssm_api_port" {
  description = "Nome do parâmetro SSM para API_PORT."
  type        = string
}

variable "ssm_api_port" {
  description = "Valor da porta da aplicação Node."
  type        = string
}

variable "tags_ssm_api_port" {
  description = "Tags aplicadas ao parâmetro API_PORT."
  type        = map(string)
}

############################
# DB_DATABASE
############################

variable "name_ssm_db_database" {
  description = "Nome do parâmetro SSM para DB_DATABASE."
  type        = string
}

variable "ssm_db_database" {
  description = "Nome do banco de dados PostgreSQL."
  type        = string
}

variable "tags_ssm_db_database" {
  description = "Tags aplicadas ao parâmetro DB_DATABASE."
  type        = map(string)
}

############################
# DB_HOST
############################

variable "name_ssm_db_host" {
  description = "Nome do parâmetro SSM para DB_HOST."
  type        = string
}

variable "ssm_db_host" {
  description = "Endpoint do banco PostgreSQL."
  type        = string
}

variable "tags_ssm_db_host" {
  description = "Tags aplicadas ao parâmetro DB_HOST."
  type        = map(string)
}

############################
# DB_PORT
############################

variable "name_ssm_db_port" {
  description = "Nome do parâmetro SSM para DB_PORT."
  type        = string
}

variable "ssm_db_port" {
  description = "Porta do banco PostgreSQL."
  type        = string
}

variable "tags_ssm_db_port" {
  description = "Tags aplicadas ao parâmetro DB_PORT."
  type        = map(string)
}

############################
# DB_USER
############################

variable "name_ssm_db_user" {
  description = "Nome do parâmetro SSM para DB_USER."
  type        = string
}

variable "ssm_db_user" {
  description = "Usuário do banco PostgreSQL."
  type        = string
}

variable "tags_ssm_db_user" {
  description = "Tags aplicadas ao parâmetro DB_USER."
  type        = map(string)
}

############################
# DB_PASSWORD
############################

variable "name_ssm_db_password" {
  description = "Nome do parâmetro SSM para DB_PASSWORD."
  type        = string
}

variable "ssm_db_password" {
  description = "Senha do banco PostgreSQL."
  type        = string
  sensitive   = true
}

variable "tags_ssm_db_password" {
  description = "Tags aplicadas ao parâmetro DB_PASSWORD."
  type        = map(string)
}

############################
# Task Definition - API XPTO
############################

variable "task_family_api_xpto" {
  description = "Nome da familia da task"
  type        = string  
}

variable "cpu_api_xpto" {
  description = "CPU minima para Fargate"
  type        = string  
}

variable "memory_api_xpto" {
  description = "Memoria minima para Fargate"
  type        = string  
}

variable "ecr_repository_url" {
  description = "URL do repositorio ECR"
  type        = string  
}

variable "container_image_tag" {
  description = "Tag da imagem no ECR"
  type        = string
  default     = "latest"
}

variable "container_name_api_xpto" {
  description = "Nome do container dentro da task"
  type        = string  
}

variable "log_group_api_xpto" {
  description = "Caminho dos logs no CloudWatch"
  type        = string  
}

variable "aws_region" {
  type    = string  
}

variable "network_mode_api_xpto" {
  description = "Modo de rede da Task (Fargate exige awsvpc)"
  type        = string  
}

variable "compatibilities_api_xpto" {
  description = "Compatibilidades da task"
  type        = list(string)  
}

############################
# Service - API XPTO
############################

variable "desired_tasks" {
  description = "Quantidade de instâncias da Task a serem executadas"
  type        = number  
}

variable "service_name" {
  description = "Nome do Serviço"
  type        = string
}

variable "servicetype" {
  description = "Tipo de lançamento do serviço (ex: FARGATE ou EC2)"
  type        = string
}

variable "assigin_ip" {
  description = "Booleano para determinar se a Task recebe um IP público diretamente"
  type        = bool  
}


############################
# SNS | SNS Subscription 
############################
variable "topic_name" {
  description = "tópico SNS onde será feita a assinatura"
  type        = string
}

variable "protocol" {
  description = "Protocolo para a assinatura (ex: email, sms, lambda, sqs)"
  type        = string  
}

variable "endpoint" {
  description = "O endpoint da assinatura (e-mail, número de telefone, ARN da lambda)"
  type        = string
}

############################
# Lambda Deploy 
############################
variable "lambda_deploy_name" {
  description = "Nome da Lambda"
  type        = string
}

variable "lambda_deploy_name2" {
  description = "Nome da Lambda"
  type        = string
}


############################
# CodeDeploy 
############################

variable "cd_appname" {
  description = "Nome do CodeDeploy "
  type        = string
}
variable "dp_name" {
  description = "Nome do Deployment Group"
  type        = string
}

