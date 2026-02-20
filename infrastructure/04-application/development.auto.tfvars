#----------# Configurações de api_xpto #-----------#
cluster_name_api_xpto  = "jpn_api_xpto"
arn_namespace_api_xpto = "arn:aws:servicediscovery:us-east-1:545009856687:namespace/ns-feiteanv6uzjkboe"
insights_api_xpto      = false
capacity_api_xpto      = ["FARGATE", "FARGATE_SPOT"]

tags_api_xpto = {
  Name        = "jpnapi_xpto"
  Service     = "api_xpto"
  Criticality = "medium"
}

#----------# Configurações do ALB development #-----------#

api_jpn_name = "api-jpn-xpto"
alb_internal           = false
alb_type               = "application"
alb_enable_http2       = true
alb_ip_address_type    = "ipv4"
alb_deletion_protection = false

alb_api_jpn_tags = {
  "Backup"      = "no"
  "CostCenter"  = "devops"
  "CreatedBy"   = "devops"
  "Criticality" = "medium"
  "Department"  = "TI"
  "Environment" = ""
  "Lifecycle"   = "permanent"
  "Name"        = "jpn-load-balancer-"
  "Owner"       = "devops"
  "Project"     = "jpn"
}

#----------# Configurações do Target Group development #-----------#
tg_api_jpn_name             = "tg-jpnApiService"
tg_api_jpn_port             = 80
tg_api_jpn_target_type      = "ip"
tg_api_jpn_protocol         = "HTTP"
tg_api_jpn_protocol_version = "HTTP1"

tg_api_jpn_tags = {
  "Backup"      = "no"
  "CostCenter"  = "devops"
  "CreatedBy"   = "devops"
  "Criticality" = "high"
  "Department"  = "TI"
  "Environment" = ""
  "Lifecycle"   = "permanent"
  "Name"        = "tg-jpn-"
  "Owner"       = "devops"
  "Project"     = "jpn"
}

#----------# Configurações do Listener development #-----------#
listener_api_jpn_port       = 443
listener_api_jpn_protocol   = "HTTPS"
listener_api_jpn_ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
listener_api_jpn_cert_arn   = "arn:aws:acm:us-east-1:545009856687:certificate/2f2d904a-2e5e-4075-9fcd-7036c30bd919"

listener_api_jpn_tags = {
  "Name"        = "listener-api-jpn-443"   
}

listener_api_jpn_80_port     = 80
listener_api_jpn_80_protocol = "HTTP"

listener_api_jpn_80_tags = {
  "Name"        = "listener-api-jpn-80"
}