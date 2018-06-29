#CREATE VPCs
resource "aws_vpc" "vpc" {
  cidr_block            = "${var.vpcCidr}"

  tags {
    Environment = "${var.envName}"
    Name = "${var.envName}-vpc"
  }
}
