#----------# VPC #-----------#
module "vpc_jpn" {
  source         = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/vpc?ref=main"
  vpc_cidr_block = var.vpc_cidr_block_jpn
  tags           = merge(local.common_tags, var.tags_vpc_jpn)
}

#----------# Subnet Public #-----------#
module "jpn_subnet_public" {
  source            = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/subnets?ref=main"
  vpc_id            = module.vpc_jpn.vpc_id
  subnet_name       = var.public_subnet_jpn_names
  subnet_cidr       = var.subnet_cidr_blocks_jpn_public
  availability_zone = var.availability_zones_jpn_public
  tags              = merge(local.common_tags, var.tags_public_jpn_subnet)
}

#----------# Subnet Private #-----------#
module "jpn_subnet_private" {
  source            = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/subnets?ref=main"
  vpc_id            = module.vpc_jpn.vpc_id
  subnet_name       = var.private_subnet_jpn_names
  subnet_cidr       = var.subnet_cidr_blocks_jpn_private
  availability_zone = var.availability_zones_jpn_private

  tags = merge(local.common_tags, var.tags_private_jpn_subnet)
}

#----------# Internet Gateway #-----------#
module "internet_gateway" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/internet-gateway?ref=main"
  vpc_id = module.vpc_jpn.vpc_id
  tags   = merge(local.common_tags, var.tags_internet_gateway)
}

#----------# Public Route Table #-----------#
module "jpn_rt_public" {
  source     = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route-table?ref=main"
  subnet_ids = values(module.jpn_subnet_public.subnet_id)
  vpc_id     = module.vpc_jpn.vpc_id
  tags       = var.tags_rt_jpn_public
}

#----------# Public Route Table Association #-----------#
module "jpn_rt_association_public" {
  source         = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route-table-association?ref=main"
  subnet_ids     = values(module.jpn_subnet_public.subnet_id)
  route_table_ids = module.jpn_rt_public.route_table_ids
}


#------# Routes public to Internet Gateway #------#
module "public_routes" {
  source         = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route?ref=main"
  route_table_id = module.jpn_rt_public.route_table_id      
  routes_json    = file("${path.module}/routes/public.json")
}


