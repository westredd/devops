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
    "${var.homeWorker}",
	"10.60.70.0/24",
  ]
}

resource "aws_security_group" "sg_mgmt" {
  name        = "sg_mgmt"
  description = "Management Access"
  vpc_id      = "${aws_vpc.management.id}"

  tags {
    Name                = "sg_mgmt"
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

resource "aws_security_group_rule" "sg_mgmt" {
  type                     = "ingress"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sg_mgmt.id}"
  cidr_blocks = [
    "80.5.30.63/32",
    "83.231.170.196/32",

  ]
}

resource "aws_security_group_rule" "sg_mgmt-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.sg_mgmt.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}