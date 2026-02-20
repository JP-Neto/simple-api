#---- RDS development ----#
db_instance_identifier = "rds-development"
db_name                = "apinodedb"
engine                 = "postgres"
db_engine_version      = "17.2"

db_instance_class    = "db.t3.micro"
db_allocated_storage = 20

db_username = "dbre"
db_password = null

#db_subnet_group_name = "development-db-subnet-group"
db_availability_zone = "us-east-1a"

db_storage_encrypted            = true
db_deletion_protection          = false
db_performance_insights_enabled = true
db_monitoring_interval          = 0
monitoring_role_arn             = null
publicly_accessible             = false
auto_minor_version_upgrade = false
copy_tags_to_snapshot      = true

rds_tags = {
  Name        = "rds-development"
  Criticality = "low"
}

#---- Parameter Group development ----#
parameter_group_name        = "development-pg17"
family                      = "postgres17"
#parameter_group_description = "development PostgreSQL17"

parameter_group_tags = {
  Name        = "development-pg17"
  Criticality = "low"
}

#--- DB Subnet Groups Configuration ---#

# Nomes dos grupos
subnet_group_name_private = "sub-private"
subnet_group_name_public  = "sub-public"

# Descrições
description_private = "Private subnets"
description_public  = "Public subnets"

# Tags do Subnet Group
tags_subnet_group_private = {
  Criticality = "low"
}

tags_subnet_group_public = {
  Criticality = "low"
}