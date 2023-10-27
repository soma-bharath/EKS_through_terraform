data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["default"] # Replace with the name of your VPC
  }
}

data "aws_security_group" "default_sg" {
  name = "default"
  vpc_id = data.aws_vpc.existing_vpc.id # Replace with the ID of your VPC
}
