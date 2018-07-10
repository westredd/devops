#VPC
resource "aws_vpc" "management" {
  cidr_block = "${var.grpCidr}"  #"10.200.80.0/21" 
  tags {
    Name = "Group Management VPC"
  }
}

#Subnet
resource "aws_subnet" "centralmanagement1c"{
	availability_zone = "eu-west-2c"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.82.0/24"
	tags {
		Name = "CentralManagement1c"
	}

}

resource "aws_subnet" "centraldevops1a"{
	availability_zone = "eu-west-2a"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.83.0/24"
	tags {
		Name = "CentralDevops1a"
	}

}

resource "aws_subnet" "centralmanagement1a"{
	availability_zone = "eu-west-2a"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.80.0/24"
	tags {
		Name = "CentralManagement1a"
	}

}

resource "aws_subnet" "centralpublicaccess1b"{
	availability_zone = "eu-west-2b"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.85.0/24"
	tags {
		Name = "CentralPublicAccess1b"
	}

}

resource "aws_subnet" "centralmanagement1b"{
	availability_zone = "eu-west-2b"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.81.0/24"
	tags {
		Name = "CentralManagement1b"
	}

}

resource "aws_subnet" "centralpublicaccess1a"{
	availability_zone = "eu-west-2a"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.84.0/24"
	tags {
		Name = "CentralPublicAccess1a"
	}

}

resource "aws_subnet" "centralpublicaccess1c"{
	availability_zone = "eu-west-2c"
	vpc_id = "${aws_vpc.management.id}"
	cidr_block = "10.200.86.0/24"
	tags {
		Name = "CentralPublicAccess1c"
	}

}



#IGW
resource "aws_internet_gateway" "CentralManagement" {
	vpc_id = "${aws_vpc.management.id}"
	tags {
		Name = "centralManagement_igw"
	}
}

