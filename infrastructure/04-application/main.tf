
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
/*
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

#----------# Target Group #-----------#
module "tg_api_jpn" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/target_group?ref=main"

  name     = var.tg_api_jpn_name
  port     = var.tg_api_jpn_port
  protocol = var.tg_api_jpn_protocol
  vpc_id   = data.terraform_remote_state.connectivity.outputs.vpc_id  
}

#----------# ALB Listener HTTP #-----------#
module "alb_listener_http_api_jpn" {
  source           = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener?ref=main"
  lb_arn           = module.alb_api_jpn.lb_arn
  port             = var.listener_http_port
  protocol         = var.listener_http_protocol
  target_group_arn = module.tg_api_jpn.arn
}

#----------# ALB Listener HTTPS #-----------#
module "alb_listener_https_api_jpn" {
  source           = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/lb_listener?ref=main"
  lb_arn           = module.alb_api_jpn.lb_arn
  port             = var.listener_https_port
  protocol         = var.listener_https_protocol
  certificate_arn  = var.listener_certificate_arn
  target_group_arn = module.tg_api_jpn.arn
} 
*/

#--- Parameter Store ---#

# API_PORT
module "ssm_api_port" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_api_port
  description = "Porta da API Node"
  type        = var.ssm_type["string"]
  tags        = var.tags_ssm_api_port
  value       = var.ssm_api_port
}

# DB_DATABASE
module "ssm_db_database" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_db_database
  description = "Nome do database PostgreSQL"
  type        = var.ssm_type["string"]
  tags        = var.tags_ssm_db_database
  value       = var.ssm_db_database
}

# DB_HOST
module "ssm_db_host" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_db_host
  description = "Endpoint do banco PostgreSQL"
  type        = var.ssm_type["string"]
  tags        = var.tags_ssm_db_host
  value       = var.ssm_db_host
}

# DB_PORT
module "ssm_db_port" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_db_port
  description = "Porta do banco PostgreSQL"
  type        = var.ssm_type["string"]
  tags        = var.tags_ssm_db_port
  value       = var.ssm_db_port
}

# DB_USER
module "ssm_db_user" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_db_user
  description = "Usuário do banco PostgreSQL"
  type        = var.ssm_type["string"]
  tags        = var.tags_ssm_db_user
  value       = var.ssm_db_user
}

# DB_PASSWORD 
module "ssm_db_password" {
  source      = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ssm?ref=main"
  name        = var.name_ssm_db_password
  description = "Senha do banco PostgreSQL"
  type        = var.ssm_type["secure_string"]
  tags        = var.tags_ssm_db_password
  value       = var.ssm_db_password
}


#----------# ECS Task Definition - API XPTO #-----------#

module "task_definition_api_xpto" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/compute/ecs_task_definition?ref=main"

  family                   = var.task_family_api_xpto
  network_mode             = var.network_mode_api_xpto
  requires_compatibilities = var.compatibilities_api_xpto
  cpu                      = var.cpu_api_xpto
  memory                   = var.memory_api_xpto
  execution_role_arn       = data.terraform_remote_state.security.outputs.ecs_task_execution_role_arn
  task_role_arn            = data.terraform_remote_state.security.outputs.ecs_task_role_arn

  container_definitions = [
    {
      name      = var.container_name_api_xpto
      image     = "${var.ecr_repository_url}:${var.container_image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = var.tg_api_jpn_port
          hostPort      = var.tg_api_jpn_port
          protocol      = "tcp"
        }
      ]
      secrets = [
        { name = "API_PORT",    valueFrom = module.ssm_api_port.arn },
        { name = "DB_DATABASE", valueFrom = module.ssm_db_database.arn },
        { name = "DB_HOST",     valueFrom = module.ssm_db_host.arn },
        { name = "DB_PORT",     valueFrom = module.ssm_db_port.arn },
        { name = "DB_USER",     valueFrom = module.ssm_db_user.arn },
        { name = "DB_PASSWORD", valueFrom = module.ssm_db_password.arn }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_api_xpto
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ]

  tags = local.common_tags
}
