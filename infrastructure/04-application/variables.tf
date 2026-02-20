#----------# Variáveis ECS Cluster api_xpto #-----------#
variable "cluster_name_api_xpto" {
  description = "Nome do cluster ECS para a aplicação de api_xpto"
  type        = string
}

variable "namespace_api_xpto" {
  description = "ARN do Cloud Map Namespace para Service Connect"
  type        = string
}

variable "insights_api_xpto" {
  description = "Define se o Container Insights está ativo ou não"
  type        = bool
}

variable "capacity_api_xpto" {
  description = "Lista de Capacity Providers (FARGATE / FARGATE_SPOT)"
  type        = list(string)
}

variable "tags_api_xpto" {
  description = "Tags específicas para o recurso de api_xpto"
  type        = map(string)
  default     = {}
}

#----------# Variáveis ALB development #-----------#
variable "api_jpn_name" {
  type        = string
  description = "Nome do Load Balancer"
}

variable "alb_internal" {
  type        = bool
  description = "Define se o ALB é interno ou voltado para internet"
}

variable "alb_type" {
  type        = string
  description = "Tipo do Load Balancer (application ou network)"
}

variable "alb_enable_http2" {
  type = bool
}

variable "alb_ip_address_type" {
  type = string
}

variable "alb_deletion_protection" {
  type = bool
}

variable "alb_api_jpn_tags" {
  type        = map(string)
  description = "Tags completas do Load Balancer conforme console"
}

variable "access_logs_bucket" {
  type = string
}

variable "access_logs_prefix" {
  type = string
}

variable "access_logs_enabled" {
  type = bool
}

#----------# Variáveis Target Group development #-----------#
variable "tg_api_jpn_name" {
  type        = string
  description = "Nome do Target Group para a API"
}

variable "tg_api_jpn_port" {
  type = number
}

variable "tg_api_jpn_target_type" {
  type = string
}

variable "tg_api_jpn_protocol" {
  type = string
}

variable "tg_api_jpn_protocol_version" {
  type = string
}

variable "tg_api_jpn_tags" {
  type = map(string)
}

##----------# Variáveis Listener development #-----------#
variable "listener_api_jpn_port" {
  type = number
}

variable "listener_api_jpn_protocol" {
  type = string
}

variable "listener_api_jpn_ssl_policy" {
  type = string
}

variable "listener_api_jpn_cert_arn" {
  type = string
}

variable "listener_api_jpn_tags" {
  type = map(string)
}

variable "listener_api_jpn_80_port" {
  type = number
}

variable "listener_api_jpn_80_protocol" {
  type = string
}

variable "listener_api_jpn_80_tags" {
  type = map(string)
}