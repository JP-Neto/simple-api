#----------# VPC Outputs #-----------#
output "vpc_id" {
  description = "ID da VPC de "
  value       = module.vpc_jpn.vpc_id
}

#----------# Subnet Outputs #-----------#
output "public_subnet_ids" {
  description = "Lista de IDs das Subnets Públicas"
  value       = values(module.jpn_subnet_public.subnet_id)
}

output "private_subnet_ids" {
  description = "Lista de IDs das Subnets Privadas"
  value       = values(module.jpn_subnet_private.subnet_id)
}
