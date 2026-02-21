
# #----------# Security Group ECS Outputs #-----------#

output "sg_ecs_id" {
  description = "O ID do Security Group do ECS"
  value       = module.sg_ecs.security_group_id
}

# #----------# Security Group RDS Postgres Outputs #-----------#

output "sg_rds_postgres_id" {
  description = "O ID do Security Group do RDS Postgres"
  value       = module.sg_rds_postgres.security_group_id
}
