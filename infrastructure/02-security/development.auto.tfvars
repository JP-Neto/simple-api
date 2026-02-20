#---SG ECS ---#
name_sg_ecs        = "jpn-sg-ecs"
description_sg_ecs = "SG Ecs Cluster"

tags_sg_ecs = {
  Name        = "jpn-sg-ecs"
  Service     = "ecs-app"
  Criticality = "high"
}

#---SG RDS POSTGRES ---#
name_sg_rds_postgres        = "rds-sg-postgres"
description_sg_rds_postgres = "Permite acesso ao Postgres"

tags_sg_rds_postgres = {
  Name        = "jpn-sg-rds-posgress"
  Service     = "rds-postgres"
  Criticality = "high"
}