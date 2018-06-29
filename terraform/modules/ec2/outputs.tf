#output "instanceName" {
#  value = "${aws_instance.instance.name}"
#}

output "instanceId" {
  value = "${aws_instance.instance.id}"
}

output "instancePrivateIp" {
  value = "${aws_instance.instance.private_ip}"
}

#cannot pass out EiP due to lack of conditional logic on EiP resource creation
#output "instanceEips" {
#  value = ["${aws_eip.instance.*.public_ip}"]
#}

