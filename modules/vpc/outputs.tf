output "vpcId" {
  value = "${aws_vpc.vpc.id}"
}




#output "igwId" {
#	value = "${aws_internet_gateway.igw.id}"
#}
#
#output "natGwId" {
#	value = "${aws_nat_gateway.natgw.id}"
#}
#
#output "publicSubnetIds" {
#  value = ["${aws_subnet.public.*.id}"]
#}
#
#output "privateSubnetIds" {
#  value = ["${aws_subnet.private.*.id}"]
#}
#
#output "dhcpOptionsId" {
#  value = "${aws_vpc_dhcp_options.default.id}"
#}
#
#output "envName" {
#  value = "${var.envName}"
#}
#
#output "awsRegion" {
#  value = "${var.awsRegion}"
#}
#
##output "natGwIp" {
##	value = "${aws_eip.natgw.public_id}"
##}