#---- RDS Development ----#
variable "db_instance_identifier" {
  description = "O identificador único da instância RDS"
  type        = string
}

variable "db_name" {
  description = "O nome do banco de dados inicial"
  type        = string
}

variable "engine" {
  description = "Motor do banco de dados (postgres, mysql, etc)"
  type        = string
}

variable "db_engine_version" {
  description = "Versão do motor do banco de dados"
  type        = string
}

variable "db_instance_class" {
  description = "Tipo de instância (Ex: db.t3.medium)"
  type        = string
}

variable "db_allocated_storage" {
  description = "Espaço em disco em GB"
  type        = number
}

variable "db_username" {
  description = "Usuário mestre do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do usuário mestre"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "Nome do grupo de subnets do RDS"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de SGs permitidos"
  type        = list(string)
}

variable "db_availability_zone" {
  description = "AZ onde a instância será alocada"
  type        = string
}

variable "db_storage_encrypted" {
  description = "Habilita criptografia em repouso"
  type        = bool
}

variable "db_deletion_protection" {
  description = "Proteção contra remoção acidental"
  type        = bool
}

variable "db_performance_insights_enabled" {
  description = "Habilita o Performance Insights"
  type        = bool
}

variable "db_monitoring_interval" {
  description = "Intervalo do Enhanced Monitoring em segundos"
  type        = number
}

variable "monitoring_role_arn" {
  description = "ARN da role de monitoramento"
  type        = string
}

variable "rds_tags" {
  description = "Tags para os recursos do RDS"
  type        = map(string)
  default     = {}
}

#---- Particularidades de Ambiente (Evitar Drift) ----#
variable "auto_minor_version_upgrade" {
  type    = bool
  default = false
}

variable "copy_tags_to_snapshot" {
  type    = bool
  default = true
}

variable "publicly_accessible" {
  type = bool
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

#---- Parameter Group development ----#
variable "parameter_group_name" {
  description = "Nome identificador do DB Parameter Group"
  type        = string
}

variable "family" {
  description = "Família do motor do banco (Ex: postgres17)"
  type        = string
}

variable "parameter_group_description" {
  description = "Descrição do parameter group"
  type        = string
}

variable "parameter_group_tags" {
  description = "Tags para o Parameter Group"
  type        = map(string)
  default     = {}
}

#--- DB Subnet Groups ---#
variable "subnet_group_name_private" {
  type = string
}

variable "subnet_group_name_public" {
  type = string
}

variable "description_private" {
  type = string
}

variable "description_public" {
  type = string
}

variable "tags_subnet_group_private" {
  type    = map(string)
  default = {}
}

variable "tags_subnet_group_public" {
  type    = map(string)
  default = {}
}

#--- Listas Dinâmicas ---#
variable "parameters_list" {
  description = "Lista de parâmetros customizados para o DB"
  type        = list(map(string))
  default     = []
}

variable "tags_subnet_group_rds" {
  type    = map(string)
  default = {}
}