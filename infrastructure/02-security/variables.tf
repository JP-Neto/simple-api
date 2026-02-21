#----------# Security Group ECS #-----------#
variable "name_sg_ecs" {
  description = "O nome do Security Group para o cluster ECS"
  type        = string
}

variable "description_sg_ecs" {
  description = "Descrição detalhada da finalidade deste Security Group"
  type        = string
  default     = "Security Group para as aplicacoes ECS"
}

variable "tags_sg_ecs" {
  description = "Tags extras para o Security Group do ECS"
  type        = map(string)
  default     = {}
}

#----------# Security Group RDS PostgreSQL #-----------#
variable "name_sg_rds_postgres" {
  description = "O nome do Security Group para o cluster RDS PostgreSQL"
  type        = string
}

variable "description_sg_rds_postgres" {
  description = "Descrição detalhada da finalidade deste Security Group"
  type        = string
  default     = "Security Group para as aplicacoes RDS PostgreSQL"
}

variable "tags_sg_rds_postgres" {
  description = "Tags extras para o Security Group do RDS PostgreSQL"
  type        = map(string)
  default     = {}
}

variable "ecs_execution_role" {
  description = "Role par Execução da Task"
  type        = string
 
}
variable "ecs_task_role" {
  description = "Role para ecs Taks"
  type        = string 
}

