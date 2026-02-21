############################
# ECS
############################

cluster_name_api_xpto = "ecs-api-xpto"
namespace_api_xpto    = "api-xpto.local"
insights_api_xpto     = false
capacity_api_xpto     = ["FARGATE", "FARGATE_SPOT"]

tags_api_xpto = {
  Environment = "dev"
  Project     = "api-xpto"
}

############################
# ALB
############################

api_jpn_name            = "alb-api-xpto-dev"
alb_internal            = false
alb_type                = "application"
alb_deletion_protection = false
access_logs_enabled     = false
access_logs_bucket      = ""
access_logs_prefix      = ""

alb_api_jpn_tags = {
  Environment = "dev"
  Project     = "api-xpto"
}

############################
# Target Group
############################

tg_api_jpn_name             = "tg-api-xpto-dev"
tg_api_jpn_port             = 3000
tg_api_jpn_protocol         = "HTTP"
tg_api_jpn_protocol_version = "HTTP1"

tg_api_jpn_tags = {
  Environment = "dev"
  Project     = "api-xpto"
}

############################
# Listeners
############################

listener_http_port     = 80
listener_http_protocol = "HTTP"

listener_https_port     = 443
listener_https_protocol = "HTTPS"

listener_certificate_arn = null



############################
# SSM Parameter Store
############################
ssm_type = {
  string        = "String"
  secure_string = "SecureString"
}

# API
name_ssm_api_port = "/simple-api/dev/API_PORT"
ssm_api_port      = "3000"
tags_ssm_api_port = {
  Environment = "dev"
  Application = "simple-api"
}

# DB
name_ssm_db_database = "/simple-api/dev/DB_DATABASE"
ssm_db_database      = "apinodedb"
tags_ssm_db_database = {
  Environment = "dev"
  Application = "simple-api"
}

name_ssm_db_host = "/simple-api/dev/DB_HOST"
ssm_db_host      = "rds-development.cdimoe6mg5r0.us-east-2.rds.amazonaws.com"
tags_ssm_db_host = {
  Environment = "dev"
  Application = "simple-api"
}

name_ssm_db_port = "/simple-api/dev/DB_PORT"
ssm_db_port      = "5432"
tags_ssm_db_port = {
  Environment = "dev"
  Application = "simple-api"
}

name_ssm_db_user = "/simple-api/dev/DB_USER"
ssm_db_user      = "dbre"
tags_ssm_db_user = {
  Environment = "dev"
  Application = "simple-api"
}

name_ssm_db_password = "/simple-api/dev/DB_PASSWORD"
ssm_db_password      = "JpnCloud2026Postgres"
tags_ssm_db_password = {
  Environment = "dev"
  Application = "simple-api"
}


############################
# Task Definition - API XPTO
############################

task_family_api_xpto    = "simple-api-task"
cpu_api_xpto            = "256"      
memory_api_xpto         = "512"      
ecr_repository_url      = "196786876277.dkr.ecr.us-east-2.amazonaws.com/simple-api"
container_image_tag     = "98c4d6a"
container_name_api_xpto = "simple-api-container"
log_group_api_xpto      = "/ecs/simple-api-dev"
aws_region              = "us-east-2"
network_mode_api_xpto   = "awsvpc"
compatibilities_api_xpto = ["FARGATE"]

############################
# ECS Service - API XPTO
############################
service_name = "simple-api-task-service"
desired_tasks = 1
servicetype   = "FARGATE"
assigin_ip    = true

