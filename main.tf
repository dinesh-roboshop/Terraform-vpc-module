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

resource "aws_subnet" "database_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  count = length(var.database_subnet_cidr)
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.database_subnet_tags,
    {
     Name = "${local.name}-database-${local.azs[count.index]}"

    }

  )
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = merge(
    var.common_tags,
    var.natgw_tags,
    {
     Name = "${local.name}"

    }

  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

