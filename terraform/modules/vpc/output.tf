output "vpcId" {
  value = "${aws_vpc.vpc.id}"
}

output "igwId" {
 value = "${aws_internet_gateway.igw.id}"
}

output "privateSubnetIds" {
  value = ["${aws_subnet.private.*.id}"]
}

output "publicSubnetIds" {
  value = ["${aws_subnet.public.*.id}"]
}

#output "natGwId" {
#  value = "${aws_nat_gateway.natgw.id}"
#}

  