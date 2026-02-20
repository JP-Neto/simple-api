############################
# ECS
############################

variable "cluster_name_api_xpto" {
  description = "Nome do cluster ECS onde os serviços da API XPTO serão executados."
  type        = string
}

variable "namespace_api_xpto" {
  description = "Nome do namespace Service Discovery utilizado pelo ECS (Cloud Map)."
  type        = string
}

variable "insights_api_xpto" {
  description = "Habilita ou desabilita o Container Insights no cluster ECS."
  type        = bool
}

variable "capacity_api_xpto" {
  description = "Lista de capacity providers associados ao cluster (ex: FARGATE, FARGATE_SPOT)."
  type        = list(string)
}

variable "tags_api_xpto" {
  description = "Mapa de tags adicionais aplicadas aos recursos do ECS."
  type        = map(string)
}

############################
# ALB
############################

variable "api_jpn_name" {
  description = "Nome do Application Load Balancer da API XPTO."
  type        = string
}

variable "alb_internal" {
  description = "Define se o ALB será interno (true) ou internet-facing (false)."
  type        = bool
}

variable "alb_type" {
  description = "Tipo do Load Balancer (ex: application)."
  type        = string
}

variable "alb_deletion_protection" {
  description = "Habilita ou desabilita a proteção contra exclusão do ALB."
  type        = bool
}

variable "access_logs_bucket" {
  description = "Nome do bucket S3 onde os logs de acesso do ALB serão armazenados."
  type        = string
}

variable "access_logs_prefix" {
  description = "Prefixo utilizado para armazenar os logs de acesso no bucket S3."
  type        = string
}

variable "access_logs_enabled" {
  description = "Define se o access log do ALB estará habilitado."
  type        = bool
}

variable "alb_api_jpn_tags" {
  description = "Mapa de tags aplicadas ao ALB."
  type        = map(string)
}

############################
# Target Group
############################

variable "tg_api_jpn_name" {
  description = "Nome do Target Group associado ao ALB para a API XPTO."
  type        = string
}

variable "tg_api_jpn_port" {
  description = "Porta que o Target Group utilizará para encaminhar tráfego aos serviços ECS."
  type        = number
}

variable "tg_api_jpn_protocol" {
  description = "Protocolo utilizado pelo Target Group (ex: HTTP)."
  type        = string
}

variable "tg_api_jpn_protocol_version" {
  description = "Versão do protocolo do Target Group (ex: HTTP1, HTTP2, GRPC)."
  type        = string
}

variable "tg_api_jpn_tags" {
  description = "Mapa de tags aplicadas ao Target Group."
  type        = map(string)
}

############################
# Listeners
############################

variable "listener_http_port" {
  description = "Porta do listener HTTP do ALB (normalmente 80)."
  type        = number
}

variable "listener_http_protocol" {
  description = "Protocolo do listener HTTP (normalmente HTTP)."
  type        = string
}

variable "listener_https_port" {
  description = "Porta do listener HTTPS do ALB (normalmente 443)."
  type        = number
}

variable "listener_https_protocol" {
  description = "Protocolo do listener HTTPS (normalmente HTTPS)."
  type        = string
}

variable "listener_certificate_arn" {
  description = "ARN do certificado ACM utilizado no listener HTTPS."
  type        = string
}