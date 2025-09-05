data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_vpc" "default" {
 default = true
}

data "aws_route_table" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}