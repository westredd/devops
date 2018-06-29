#VPC
resource "aws_vpc" "management" {
  cidr_block = "10.200.80.0/21"
  tags {
    Name = "Group Management VPC"
  }
}