#=========================================================
# 1. RDS INSTANCE CONFIGURATION
#=========================================================
variable "db_instance_identifier" {
  description = "Identificador unico da instancia RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
}

variable "engine" {
  description = "Motor do banco de dados (postgres, mysql, etc)"
  type        = string
}

variable "db_engine_version" {
  description = "Versao do motor do banco de dados"
  type        = string
}

variable "db_instance_class" {
  description = "Tipo de instancia (Ex: db.t3.micro)"
  type        = string
}

variable "db_allocated_storage" {
  description = "Espaco em disco em GB"
  type        = number
}

#---------------------------------------------------------
# 2. CREDENTIALS (SENSITIVE)
#---------------------------------------------------------
variable "db_username" {
  description = "Usuario mestre do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do usuario mestre - Injetada via Secret"
  type        = string
  sensitive   = true
}

#---------------------------------------------------------
# 3. RDS BEHAVIOR & SECURITY
#---------------------------------------------------------
variable "db_storage_encrypted" {
  description = "Habilita criptografia em repouso"
  type        = bool
}

variable "db_deletion_protection" {
  description = "Protecao contra remocao acidental"
  type        = bool
}

variable "publicly_accessible" {
  description = "Define se o banco tera IP publico"
  type        = bool
}

variable "rds_tags" {
  description = "Tags especificas para o RDS"
  type        = map(string)
  default     = {}
}

#=========================================================
# 4. PARAMETER GROUP CONFIGURATION
#=========================================================
variable "parameter_group_name" {
  description = "Nome identificador do DB Parameter Group"
  type        = string
}

variable "family" {
  description = "Familia do motor do banco (Ex: postgres17)"
  type        = string
}

variable "parameter_group_tags" {
  description = "Tags para o Parameter Group"
  type        = map(string)
  default     = {}
}

#=========================================================
# 5. DB SUBNET GROUP CONFIGURATION
#=========================================================
variable "subnet_group_name_private" {
  description = "Nome do grupo de subnets privadas"
  type        = string
}

variable "tags_subnet_group_private" {
  description = "Tags para o Subnet Group"
  type        = map(string)
  default     = {}
}

#---- Variáveis de Monitoramento (Adicione para silenciar os avisos) ----#
variable "db_monitoring_interval" {
  type    = number
  default = 0
}

variable "monitoring_role_arn" {
  type    = string
  default = null
}

variable "db_performance_insights_enabled" {
  type    = bool
  default = false
}

variable "db_availability_zone" {
  type = string
}

variable "auto_minor_version_upgrade" {
  type = bool
}

variable "copy_tags_to_snapshot" {
  type = bool
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

variable "tags_subnet_group_public" {
  type    = map(string)
  default = {}
}