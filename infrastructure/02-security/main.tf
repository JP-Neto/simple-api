#----------# SG ECS #-----------#
/*
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
*/