#------- Como foi feito import deste recurso, manter os mesmos nomes das variáveis para evitar conflitos. -------#

#---SG ECS ---#
name_sg_ecs        = "default"
description_sg_ecs = "default VPC security group"

tags_sg_ecs = {
  Name        = "jpn-sg-ecs"
  Service     = "ecs-app"
  Criticality = "high"
}

#---SG RDS POSTGRES ---#
name_sg_rds_postgres        = "scg-rds-postgres"
description_sg_rds_postgres = "Permite acesso ao Postgres"

tags_sg_rds_postgres = {
  Name        = "jpn-sg-rds-posgress"
  Service     = "rds-postgres"
  Criticality = "high"
}
#------- Fim das variáveis importadas -------#