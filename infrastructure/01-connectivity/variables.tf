#----------# VPC  #-----------#
variable "vpc_cidr_block_jpn" {
  description = "CIDR block for jpn  VPC"
  type        = string
}

variable "tags_vpc_jpn" {
  description = "Tags específicas para a VPC de ."
  type        = map(string)
  default     = {}
}

#----------# Public Subnets #-----------#
variable "subnet_cidr_blocks_jpn_public" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_subnet_jpn_names" {
  description = "Names for public subnets"
  type        = set(string)
}


variable "availability_zones_jpn_public" {
  description = "Availability zones for public subnets"
  type        = list(string)
}

variable "tags_public_jpn_subnet" {
  description = "Tags específicas para as Subnets Públicas."
  type        = map(string)
  default     = {}
}

#----------# Public Routing #-----------#
variable "public_jpn_name" {
  description = "Name for public route table (Map exigido pelo módulo)"
  type        = map(string)
}

variable "tags_rt_jpn_public" {
  description = "Tags específicas para a Route Table Pública."
  type        = map(string)
  default     = {}
}

#----------# Private Subnets #-----------#
variable "subnet_cidr_blocks_jpn_private" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "private_subnet_jpn_names" {
  description = "Names for private subnets"
  type        = set(string)
}

variable "availability_zones_jpn_private" {
  description = "Availability zones for private subnets"
  type        = list(string)
}

variable "tags_private_jpn_subnet" {
  description = "Tags específicas para as Subnets Privadas."
  type        = map(string)
  default     = {}
}

#----------# Private Routing #-----------#
variable "private_jpn_name" {
  description = "Name for private route table (Map exigido pelo módulo)"
  type        = map(string)
}

variable "tags_rt_jpn_private" {
  description = "Tags específicas para a Route Table Privada."
  type        = map(string)
  default     = {}
}

#----------# Gateways #-----------#
variable "tags_internet_gateway" {
  description = "Tags específicas para o Internet Gateway."
  type        = map(string)
  default     = {}
}
