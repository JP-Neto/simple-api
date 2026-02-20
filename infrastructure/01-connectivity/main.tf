#----------# VPC #-----------#
module "vpc_jpn_" {
  source   = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/vpc?ref=main"
  vpc_cidr = var.vpc_cidr_block_jpn_
  tags     = merge(local.common_tags, var.tags_vpc_jpn_)
}

#----------# Subnet Public #-----------#
module "jpn_subnet_public" {
  source            = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/subnet?ref=main"
  vpc_id            = module.vpc_jpn_.vpc_id
  subnet_name       = var.public_subnet_jpn_names
  subnet_cidr       = var.subnet_cidr_blocks_jpn_public
  availability_zone = var.availability_zones_jpn_public
  tags              = merge(local.common_tags, var.tags_public_jpn_subnet)
}

#----------# Public Route Table #-----------#
module "jpn_rt_public" {
  source       = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route-table-lft?ref=main"
  vpc_id       = module.vpc_jpn_.vpc_id
  tags         = merge(local.common_tags, var.tags_rt_jpn_public)
}

#----------# Public Route Table Association #-----------#
module "jpn_rt_association_public_a" {
  source          = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route-table-association-lft?ref=main"
  subnet_id       = module.jpn_subnet_public.subnet_id["-public-us-east-1a"]
  route_table_id  = module.jpn_rt_public.route_table_id
}
module "jpn_rt_association_public_b" {
  source          = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route-table-association-lft?ref=main"
  subnet_id       = module.jpn_subnet_public.subnet_id["-public-us-east-1b"]
  route_table_id  = module.jpn_rt_public.route_table_id
}
/*
#------# Routes public to Internet Gateway #------#
module "public_routes" {
  source         = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/route?ref=main"
  route_table_id = module.jpn_rt_public.route_table_id      
  routes_json    = file("${path.module}/routes/public.json")
}
*/
#----------# Subnet Private #-----------#
module "jpn_subnet_private" {
  source            = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/subnet?ref=main"
  vpc_id            = module.vpc_jpn_.vpc_id
  subnet_name       = var.private_subnet_jpn_names
  subnet_cidr       = var.subnet_cidr_blocks_jpn_private
  availability_zone = var.availability_zones_jpn_private

  tags = merge(local.common_tags, var.tags_private_jpn_subnet)
}

#----------# Internet Gateway #-----------#
module "internet_gateway" {
  source = "git::https://github.com/JP-Neto/Terraform-Multi-Cloud-Modules.git//modules/aws/network/int-gateway?ref=main"
  vpc_id = module.vpc_jpn_.vpc_id
  tags   = merge(local.common_tags, var.tags_internet_gateway)
}
