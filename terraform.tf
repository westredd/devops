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

#routes
resource "aws_route_table" "MGT-Private" {
  vpc_id = "${aws_vpc.management.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.CentralManagement.id}"
  }
}  
  
resource "aws_route_table_association" "MGT-Private-centralmanagement1a" {
  subnet_id      = "${aws_subnet.centralmanagement1a.id}"
  route_table_id = "${aws_route_table.MGT-Private.id}"
}  

#IGW
resource "aws_internet_gateway" "CentralManagement" {
	vpc_id = "${aws_vpc.management.id}"
	tags {
		Name = "centralManagement"
	}
}



#resource "aws_instance" "vault" {
#  ami           = "ami-629a7405"
#  instance_type = "t2.micro"
#  key_name      = "mfd-key"
#  subnet_id     = "${aws_subnet.centralmanagement1a.id}"
#  private_ip    = "10.200.80.50"
#  associate_public_ip_address = true
#
#  vpc_security_group_ids = ["${aws_security_group.sg_mgmt.id}",
#  ]
#
#  tags {
#    Name                = "DDEVOPSAWSVLT01"
#    rbusinessUnit       = "INA"
#    rDepartment         = "S&I"
#    uProjectOrService   = "Nordic"
#    rEnvironment        = "Prod"
#    oEnvironment        = "Prod"
#    uRole               = "RDS 2012 License Server"
#    oOctopusEnvironment = "na"
#    oOtopusRole         = "na"
#    rPONumber           = "94029794"
#  }
#
#  root_block_device {
#    volume_type = "gp2"
#    volume_size = "50"
#  }
#  
#  lifecycle {
#    ignore_changes = [
#      "user_data",
#      "ami",
#    ]
#  }  
#
#}

