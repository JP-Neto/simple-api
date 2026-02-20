############################
# ECS
############################

cluster_name_api_xpto = "ecs-api-xpto"
namespace_api_xpto    = "api-xpto.local"
insights_api_xpto     = true
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
tg_api_jpn_port             = 8080
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