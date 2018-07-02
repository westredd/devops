resource "aws_security_group" "sg_prodvaultServers" {
  name        = "sg_prodvaultServers"
  description = "Sec Group for inbound requests from PROD ALB on port 8200"
  vpc_id      = "${aws_vpc.management.id}"

  tags {
    Name                = "sg_albprodvaultServers"
    environment         = "prod"
    uHostname           = ""
    uProjectOrService   = "Central Management"
    rEnvironment        = "Production"
    rBusinessUnit       = "CCS"
    rDepartment         = "CCS"
    rEnvironmentName    = "prod"
    oEnvironment        = ""
    oOctopusEnvironment = ""
    rPONumber           = "94028184"
  }
}

resource "aws_security_group_rule" "sg_prodvaultServers_allow8200FromProdAppAlb" {
  type                     = "ingress"
  from_port                = 8200
  to_port                  = 8200
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sg_prodvaultServers.id}"
  cidr_blocks = [
    "${var.cexLan}",
    "${var.homeWorker}",,
  ]
}