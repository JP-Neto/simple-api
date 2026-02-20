#---- RDS  development ----#
db_instance_identifier = "rds-development"
db_name                = "apinodedb"
engine                 = "postgres"
db_engine_version      = "17.2"
db_instance_class      = "db.t3.medium"
db_allocated_storage   = 20

db_username = "dbre"
db_password = null

db_subnet_group_name   = "development-db-subnet-group"
vpc_security_group_ids = ["sg-0a01340a93a3797f8"]
db_availability_zone   = "us-east-1a"

db_storage_encrypted   = true
db_deletion_protection = true

db_performance_insights_enabled = true
db_monitoring_interval          = 60
monitoring_role_arn             = "arn:aws:iam::545009856687:role/rds-monitoring-role"
publicly_accessible             = true
rds_tags = {
  Name        = "rds-development"
  Criticality = "medium"
}

#---- Parameter Group development ----#
parameter_group_name        = "development-pg17"
family                      = "postgres17"
parameter_group_description = "development PostgreSQL17"

parameter_group_tags = {
  Name        = "development-pg17"
  Criticality = "high"
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
  Criticality = "medium"
}

tags_subnet_group_public = {
  Criticality = "medium"
}