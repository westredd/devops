#CREATE VPCs
resource "aws_vpc" "vpc" {
  cidr_block            = "${var.vpcCidr}"

  tags {
    Environment = "${var.envName}"
    Name = "${var.envName}-vpc"
  }
}

#CREATE IGW
resource "aws_internet_gateway" "igw" {
  vpc_id  				= "${aws_vpc.vpc.id}"
  
  tags {
    Environment 		= "${var.envName}"
    Name 				= "${var.envName}-igw"
  }
}

#CREATE SUBNETS
resource "aws_subnet" "private" {
  count  				= "${length(var.privateSubnets)}"	
  vpc_id 				= "${aws_vpc.vpc.id}"
  cidr_block 			= "${var.privateSubnets[count.index]}"
  availability_zone 	= "${var.availabilityZones[count.index]}"

  tags {
    Environment = "${var.envName}"
	Name = "${var.envName}-${var.availabilityZones[count.index]}-private"
    }
}

resource "aws_subnet" "public" {
	count  = "${length(var.publicSubnets)}"	
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.publicSubnets[count.index]}"
    availability_zone = "${var.availabilityZones[count.index]}"

    tags {
        Environment = "${var.envName}"
		Name = "${var.envName}-${var.availabilityZones[count.index]}-public"
    }
}

##NATGW
#resource "aws_nat_gateway" "natgw" {
# subnet_id     = "${element(aws_subnet.public.*.id, 0)}"
# allocation_id = "${aws_eip.natgw.id}"
#}
#
#resource "aws_eip" "natgw" {
#  vpc   = true
#}

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["8.8.8.8"]
}