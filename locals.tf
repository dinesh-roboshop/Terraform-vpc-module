locals {
  name = "${var.project_name}-${var.environment}"
  azs = slice(data.aws_availability_zones.azs.names, 0, 2)
}
