resource "aws_vpc" "my-vpc" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.common_tags, 
    var.vpc_tags, 
    {
     Name = local.name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = merge(
    var.common_tags, 
    var.igw_tags, 
    {
     Name = local.name 
    }
  )
}