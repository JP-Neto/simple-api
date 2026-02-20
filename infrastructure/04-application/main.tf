#----------# ECS Cluster API XPTO #-----------#
module "ecs_namespace_api_xpto" {
  source         = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ecs_namespace?ref=main"
  namespace_name = var.namespace_api_xpto
  vpc_id         = data.terraform_remote_state.connectivity.outputs.vpc_id
  tags           = local.common_tags
}

module "ecs_cluster_api_xpto" {
  source                    = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ecs?ref=main"
  cluster_name              = var.cluster_name_api_xpto
  namespace_arn             = module.ecs_namespace_api_xpto.namespace_arn
  enable_container_insights = var.insights_api_xpto
  tags                      = merge(local.common_tags, var.tags_api_xpto)
  depends_on                = [module.ecs_namespace_api_xpto]
}

module "ecs_capacity_api_xpto" {
  source             = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ecs-capacity-provider?ref=main"
  cluster_name       = module.ecs_cluster_api_xpto.cluster_name
  capacity_providers = var.capacity_api_xpto

  depends_on = [module.ecs_cluster_api_xpto]
}

#----------# ALB development - API XPTO #-----------#
module "alb_api_jpn" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb?ref=main"

  lb_name             = var.api_jpn_name
  internal            = var.alb_internal
  type                = var.alb_type
  access_logs_enabled = var.access_logs_enabled
  access_logs_bucket  = var.access_logs_bucket
  access_logs_prefix  = var.access_logs_prefix
  security_group_ids  = [data.terraform_remote_state.security.outputs.sg_ecs_id]
  subnet_ids = [
    data.terraform_remote_state.connectivity.outputs.public_subnet_ids[0],
    data.terraform_remote_state.connectivity.outputs.public_subnet_ids[1]
  ]
  enable_deletion_protection = var.alb_deletion_protection
  tags                       = var.alb_api_jpn_tags

}

/*
#----------# Target Group development #-----------#
module "tg_api_jpn" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/target_group?ref=main"
  
  tg_name                       = var.tg_api_jpn_name
  target_group_port             = var.tg_api_jpn_port
  target_type                   = var.tg_api_jpn_target_type
  target_group_protocol         = var.tg_api_jpn_protocol
  target_group_protocol_version = var.tg_api_jpn_protocol_version   
  vpc_id = data.terraform_remote_state.connectivity.outputs.vpc_id

  tags = var.tg_api_jpn_tags
}

#----------# Listerner development #-----------#
module "alb_listener_jpn_443" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener?ref=main"

  lb_arn           = module.alb_api_jpn.lb_arn
  port             = var.listener_api_jpn_port
  protocol         = var.listener_api_jpn_protocol
  ssl_policy       = var.listener_api_jpn_ssl_policy
  certificate_arn  = var.listener_api_jpn_cert_arn
  target_group_arn = module.tg_api_jpn.target_group_arn
  
  tags = merge(local.common_tags,var.listener_api_jpn_tags)

  depends_on = [module.alb_api_jpn, module.tg_api_jpn]
}

#----------# Listerner development - Port 80 #-----------#
module "alb_listener_jpn_80" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener?ref=main"

  lb_arn           = module.alb_api_jpn.lb_arn
  port             = var.listener_api_jpn_80_port
  protocol         = var.listener_api_jpn_80_protocol     
  target_group_arn = module.tg_api_jpn.target_group_arn   
  certificate_arn  = null 
  ssl_policy       = null
  tags             = merge(local.common_tags, var.listener_api_jpn_80_tags)
  depends_on       = [module.alb_api_jpn]
}

#----------# Listerner Rules development - Port 443 #-----------#
module "listener_rule_443_1" {
  source             = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener_rule?ref=main"
  listener_arn       = module.alb_listener_jpn_443.listener_https_arn
  priority           = 1
  target_group_arn   = module.tg_api_jpn.target_group_arn
  host_header_values = ["kxc.jpn.cloud.com.br"]
}

module "listener_rule_443_2" {
  source             = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener_rule?ref=main"
  listener_arn       = module.alb_listener_jpn_443.listener_https_arn
  priority           = 2
  target_group_arn   = module.tg_api_jpn.target_group_arn
  host_header_values = ["kxc.jpn.cloud.com.br"]
}
*/

