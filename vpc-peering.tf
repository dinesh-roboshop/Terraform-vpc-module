resource "aws_vpc_peering_connection" "vpc-peering" {
  count = var.is_peering_required ? 1 : 0
  peer_vpc_id   = var.accepter_vpc_id == "" ? data.aws_vpc.default.id : var.accepter_vpc_id
  vpc_id        = aws_vpc.my-vpc.id
  auto_accept   = var.accepter_vpc_id == "" ? true : false

  tags = merge(
    var.common_tags, 
    var.vpcpeering_tags, 
    {
     Name = local.name
    }
  )
}
