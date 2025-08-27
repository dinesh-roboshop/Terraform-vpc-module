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

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  count = length(var.public_subnet_cidr)
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.public_subnet_tags,
    {
     Name = "${local.name}-public-${local.azs[count.index]}"

    }

  )
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  count = length(var.private_subnet_cidr)
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.private_subnet_tags,
    {
     Name = "${local.name}-private-${local.azs[count.index]}"

    }

  )
}