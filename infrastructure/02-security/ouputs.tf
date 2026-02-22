
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

#----------# Outputs para o Remote State #-----------#
output "ecs_task_execution_role_arn" {
  value = module.ecs_execution_role.role_arn
}

output "ecs_task_role_arn" {
  value = module.ecs_task_role.role_arn
}


output "lambda_deploy_role_arn" {
  value = module.lambda_deploy_role.role_arn
}
