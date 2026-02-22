#----------# SG ECS #-----------#

module "sg_ecs" {
  source        = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/security-group?ref=main"
  name          = var.name_sg_ecs
  description   = var.description_sg_ecs
  vpc_id        = data.terraform_remote_state.connectivity.outputs.vpc_id
  ingress_rules = jsondecode(file("${path.module}/security_rules/rules-sg-ecs.json")).ingress
  egress_rules  = jsondecode(file("${path.module}/security_rules/rules-sg-ecs.json")).egress
  tags          = merge(local.common_tags, var.tags_sg_ecs)
}

#----------# SG PostgreSQL #-----------#
module "sg_rds_postgres" {
  source        = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/security-group?ref=main"
  name          = var.name_sg_rds_postgres
  description   = var.description_sg_rds_postgres
  vpc_id        = data.terraform_remote_state.connectivity.outputs.vpc_id
  ingress_rules = jsondecode(file("${path.module}/security_rules/rules-sg-rds-postgres.json")).ingress
  egress_rules  = jsondecode(file("${path.module}/security_rules/rules-sg-rds-postgres.json")).egress
  tags          = merge(local.common_tags, var.tags_sg_rds_postgres)
}


#----------# ECS Execution Role #-----------#
module "ecs_execution_role" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/iam-role?ref=main"

  role_name               = var.ecs_execution_role
  assume_role_policy_json = file("${path.module}/policies/ecs_trust_policy.json")
  policy_json             = file("${path.module}/policies/execution_policy.json")

  tags = local.common_tags
}

#----------# ECS Task Role #-----------#
module "ecs_task_role" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/iam-role?ref=main"

  role_name               = var.ecs_task_role
  assume_role_policy_json = file("${path.module}/policies/ecs_trust_policy.json")
  policy_json             = file("${path.module}/policies/task_policy.json")

  tags = local.common_tags
}



#----------# Lambda Deploy Role #-----------#
module "lambda_deploy_role" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/iam-role?ref=main"

  role_name               = var.lambda_deploy_role_name
  assume_role_policy_json = file("${path.module}/policies/lambda_deploy_trust_policy.json")
  policy_json             = file("${path.module}/policies/lambda_deploy_policy.json")

  tags = local.common_tags
}

#----------# CodeDeploy Role #-----------#
module "codedeploy_role" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/security/iam-role?ref=main"

  role_name               = var.codedeploy_role
  assume_role_policy_json = file("${path.module}/policies/codedeploy_trust_policy.json")
  policy_json             = file("${path.module}/policies/codedeploy_policy.json")

  tags = local.common_tags
}