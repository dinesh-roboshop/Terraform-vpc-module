resource "aws_vpc_peering_connection" "vpc-peering" {
  count = var.is_peering_required ? 1 : 0
  peer_vpc_id   = var.accepter_vpc_id == "" ? data.aws_vpc.default.id : var.accepter_vpc_id
  vpc_id        = aws_vpc.my_vpc.id
  auto_accept   = var.accepter_vpc_id == "" ? true : false

  tags = merge(
    var.common_tags, 
    var.vpcpeering_tags, 
    {
     Name = local.name
    }
  )
}

resource "aws_route" "acceptor_Rote" {
  count = var.is_peering_required && var.accepter_vpc_id == ""  ? 1 : 0 
  route_table_id            = data.aws_route_table.default.id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering[0].id

}

resource "aws_route" "requestor_public_rote" {
  count = var.is_peering_required && var.accepter_vpc_id == ""  ? 1 : 0 
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block 
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering[0].id

}

resource "aws_route" "requestor_private_rote" {
  count = var.is_peering_required && var.accepter_vpc_id == ""  ? 1 : 0 
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block 
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering[0].id

}

resource "aws_route" "requestor_database_rote" {
  count = var.is_peering_required && var.accepter_vpc_id == ""  ? 1 : 0 
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block 
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peering[0].id

}
