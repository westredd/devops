#Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = "${var.vpcId}" 
 # propagating_vgws = ["${var.propagatingVgw}"]
  tags {
    Environment = "${var.envName}"
    Name = "${var.envName}-priv-table"
  }  
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igwId}"
  }
  }
  
#Route Table for Public Subnets
resource "aws_route_table" "public" {
	vpc_id = "${var.vpcId}" 
	#propagating_vgws = ["${var.propagatingVgw}"]                
	tags {
		Environment = "${var.envName}"
		Name = "${var.envName}-pub-table"
  }  
  
 route {
	cidr_block = "${var.cidr_block}"
	gateway_id = "${var.igwId}"
  }
  
  }
  
#Associate the subnets with either Private or Public tables
resource "aws_route_table_association" "private0" {
	subnet_id       = "${var.privateSubnetIds[0]}"
	route_table_id  = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private1" {
	subnet_id       = "${var.privateSubnetIds[1]}"
	route_table_id  = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "public0" {
	subnet_id       = "${var.publicSubnetIds[0]}"
	route_table_id  = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public1" {
	subnet_id       = "${var.publicSubnetIds[1]}"
	route_table_id  = "${aws_route_table.public.id}"
}

