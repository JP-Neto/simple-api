#--- DB Parameter Group ---#
module "rds_parameter_group_jpn" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/database/parameter_group?ref=main"

  parameter_group_name        = var.parameter_group_name
  family                      = var.family
  parameter_group_description = var.parameter_group_description
  parameters                  = var.parameters_list
  tags                        = merge(local.common_tags, var.parameter_group_tags)
}

#--- DB Subnet Group Private ---#
module "db_subnet_group_private" {
  source            = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/database/db_subnet_group?ref=main"
  subnet_group_name = var.subnet_group_name_private
  description       = var.description_private
  subnet_ids = [
    data.terraform_remote_state.connectivity.outputs.private_subnet_ids[0],
    data.terraform_remote_state.connectivity.outputs.private_subnet_ids[1]
  ]

  tags = merge(local.common_tags, var.tags_subnet_group_private)
}

#--- RDS Instance Development ---#
module "rds_jpn" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/database/rds?ref=main"

  db_instance_identifier          = var.db_instance_identifier
  db_name                         = var.db_name
  engine                          = var.engine
  db_engine_version               = var.db_engine_version
  db_instance_class               = var.db_instance_class
  db_allocated_storage            = var.db_allocated_storage
  db_username                     = var.db_username
  db_password                     = var.db_password
  db_subnet_group_name            = module.db_subnet_group_public.db_subnet_group_name
  vpc_security_group_ids          = [data.terraform_remote_state.security.outputs.sg_rds_postgres_id]
  db_availability_zone            = var.db_availability_zone
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  publicly_accessible             = var.publicly_accessible
  skip_final_snapshot             = var.skip_final_snapshot
  db_storage_encrypted            = var.db_storage_encrypted
  db_deletion_protection          = var.db_deletion_protection
  db_parameter_group_name         = module.rds_parameter_group_jpn.parameter_group_name
  db_performance_insights_enabled = var.db_performance_insights_enabled
  db_monitoring_interval          = var.db_monitoring_interval
  monitoring_role_arn             = var.monitoring_role_arn
  tags                            = merge(var.rds_tags, local.common_tags)
}