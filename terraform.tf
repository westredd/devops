#VPC
resource "aws_vpc" "management" {
  cidr_block = "10.200.80.0/21"
  tags {
    Name = "Group Management VPC"
  }
}

#Subnet
resource "aws_subnet" "centralmanagement1c"{
	availability_zone = "eu-west-1c"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.82.0/24"
	tags {
		Name = "CentralManagement1c"
	}

}
