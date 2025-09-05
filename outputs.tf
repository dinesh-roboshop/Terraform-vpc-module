output azs {
  value = data.aws_availability_zones.azs.names
}
output "vpc_id" {
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet[*].id

}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet[*].id
}

output "database_subnet_id" {
  value       = aws_subnet.database_subnet[*].id
}
