#----------# VPC  #-----------#
vpc_cidr_block_jpn = "10.0.0.0/16"

tags_vpc_jpn = {
  Name        = "Vpc-jpn"
  Criticality = "high"
}

#----------# Public Subnets #-----------#
subnet_cidr_blocks_jpn_public = ["10.0.0.0/20", "10.0.16.0/20"]
public_subnet_jpn_names       = ["public-us-east-2a", "public-us-east-2b"]
availability_zones_jpn_public = ["us-east-2a", "us-east-2b"]

tags_public_jpn_subnet = {
  Criticality = "high"
}

#----------# Public Routing #-----------#
public_jpn_name = {
  "us-east-2a" = "jpn-rt-public-a"
  "us-east-2b" = "jpn--rt-public-b"
}

tags_rt_jpn_public = {
  Name        = "jpn-rtb-public"
  Criticality = "medium"
}

#----------# Private Subnets #-----------#
subnet_cidr_blocks_jpn_private = ["10.0.128.0/20", "10.0.144.0/20"]
private_subnet_jpn_names       = ["private-us-east-2a", "private-us-east-2b"]
availability_zones_jpn_private = ["us-east-2a", "us-east-2b"]

tags_private_jpn_subnet = {
  Criticality = "high"
}

#----------# Private Routing #-----------#
private_jpn_name = {
  "us-east-2a" = "jpn-rt-private-a"
  "us-east-2b" = "jpn--rt-private-b"
}

tags_rt_jpn_private = {
  Name        = "jpn-rtb-private"
  Criticality = "medium"
}

#----------# Gateways #-----------#
tags_internet_gateway = {
  Name        = "jpn-igw"
  Criticality = "high"
}
