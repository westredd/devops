#Terraform Version
terraform {
  required_version = "= 0.11.1"
  backend "s3" {
    bucket     = "sni.devops.mfd-terraform-state-dev"
    key        = "terraform.tfstate"
    region     = "eu-west-2"
#   lock_table = "mfd-terraform-state-lock"
   acl        = "private"
  }
}

variable "envNameTop" {
  type    = "string"
  default = "mfddev"
}

variable "envTypeTop" {
  type    = "string"
  default = "dev"
}


#Userdata Global Source
data "template_file" "default_userdata" {
    template = "${file("..\\..\\shared\\devops_userdata.txt")}"
}


#resource "aws_sns_topic" "ec2" {
#  name 					= "ProdEc2Alert"
#  display_name			= "INAProdEC2"  
#}

#Modules
module "vpc" {
  source            = "..\\..\\modules\\vpc"  
  envName           = "${var.envNameTop}"
  vpcCidr           = "20.200.32.0/21"


  
    privateSubnets    = [
    "20.200.33.0/24",
    "20.200.35.0/24"
  ]
  
    publicSubnets     = [
    "20.200.32.0/24",
    "20.200.34.0/24"
  ]
  
    availabilityZones = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2c"
  ]
}

module "routing" {
  source            = "..\\..\\modules\\routing"  
  cidr_block		= "0.0.0.0/0"
  vpcId             = "${module.vpc.vpcId}"
  igwId				= "${module.vpc.igwId}"
  envName			= "${var.envNameTop}"
  natGwId           = "${module.vpc.igwId}"	#"${module.vpc.natGwId}"
#  propagatingVgw 	= ["${module.vpn.vpnGatewayId}"]


 
  privateSubnetIds  = [
    "${module.vpc.privateSubnetIds[0]}",
    "${module.vpc.privateSubnetIds[1]}"
  ]
    publicSubnetIds   = [
    "${module.vpc.publicSubnetIds[0]}",
    "${module.vpc.publicSubnetIds[1]}"
  ]
}

#module "ec2-lin01" {
#    source					= "..\\..\\modules\\ec2"  
#    amiId					= "ami-38eb085f" #Puppet Enterprise AMI 
#    instanceType			= "t2.large"
#	envName          		= "${var.envNameTop}"
#    subnetId				= "${module.vpc.privateSubnetIds[0]}"
#	availabilityZone		= "eu-west-2a"
#    keyName					= "${var.mfddev}"
#    iamInstanceProfile   	= "mfd-meteruse-role"
#    userData             	= ""
#    securityGroups			=  ["${aws_security_group.managementTraffic.id}",
#    ]
#    terminProtect			= false
#    addStatusCheck			= true 
##	topicArn			   	= "arn:aws:sns:eu-west-2:313533373455:ProdEc2Alert" #"${aws_sns_topic.ec2.arn}"
#    rootVolumeType   		= "gp2"
#    rootVolumeSize   		= "50"
# 	 diskSizes             = ["100"]
#	nameTag               	= "DDEVOPAWSPM01"
#	environmentTag        	= "${var.envTypeTop}"
#	environmentNameTag    	= "${var.envNameTop}"
#	projectOrServiceTag   	= "mfd"
#	roleTag               	= "webservermfd"
#	businessUnitTag       	= "nordicUnit"
#	departmentTag         	= "nordicDept"
#	costCodeTag           	= "94032060"
#	powerOffCOB			 	= "No" 
#} 

module "ec2-lin10" {
    source					= "..\\..\\modules\\ec2"  
    amiId					= "ami-38eb085f" #Puppet Enterprise AMI 
    instanceType			= "t2.large"
	envName          		= "${var.envNameTop}"
    subnetId				= "${module.vpc.privateSubnetIds[0]}"
	availabilityZone		= "eu-west-2a"
    keyName					= "${var.mfddev}"
    iamInstanceProfile   	= "mfd-meteruse-role"
    userData             	= ""
    securityGroups			=  ["${aws_security_group.managementTraffic.id}",
    ]
    terminProtect			= false
    addStatusCheck			= true 
#	topicArn			   	= "arn:aws:sns:eu-west-2:313533373455:ProdEc2Alert" #"${aws_sns_topic.ec2.arn}"
    rootVolumeType   		= "gp2"
    rootVolumeSize   		= "50"
# 	 diskSizes             = [""]
	nameTag               	= "DDEVOPAWSPM02"
	environmentTag        	= "${var.envTypeTop}"
	environmentNameTag    	= "${var.envNameTop}"
	projectOrServiceTag   	= "mfd"
	roleTag               	= "webservermfd"
	businessUnitTag       	= "nordicUnit"
	departmentTag         	= "nordicDept"
	costCodeTag           	= "94032060"
	powerOffCOB			 	= "No" 
} 


#module "ec2-lin02" {
#    source					= "..\\..\\modules\\ec2"  
#    amiId					= "ami-ee6a718a"  
#    instanceType			= "t2.micro"
#	envName          		= "${var.envNameTop}"
#    subnetId				= "${module.vpc.privateSubnetIds[0]}"
#	availabilityZone		= "eu-west-2a"
#    keyName					= "${var.mfddev}"
#    iamInstanceProfile   	= "${var.iamInstanceProfile}"
#	userData       		    = "${data.template_file.default_userdata.rendered}"
#    securityGroups			=  ["${aws_security_group.managementTraffic.id}",
#    ]
#    terminProtect			= false
#    addStatusCheck			= true 
##	topicArn			   	= "arn:aws:sns:eu-west-2:313533373455:ProdEc2Alert" #"${aws_sns_topic.ec2.arn}"
#    rootVolumeType   		= "gp2"
#    rootVolumeSize   		= "50"
#	nameTag               	= "DDEVOPAWSLIN02"
#	environmentTag        	= "${var.envTypeTop}"
#	environmentNameTag    	= "${var.envNameTop}"
#	projectOrServiceTag   	= "mfd"
#	roleTag               	= "webservermfd"
#	businessUnitTag       	= "nordicUnit"
#	departmentTag         	= "nordicDept"
#	costCodeTag           	= "94032060"
#	powerOffCOB			 	= "No" 
#} 

module "ec2-win01" {
    source					= "..\\..\\modules\\ec2"  
    amiId					= "ami-8f41a3e8"  
    instanceType			= "t2.medium"
	envName          		= "${var.envNameTop}"
    subnetId				= "${module.vpc.privateSubnetIds[0]}"
	availabilityZone		= "eu-west-2a"
    keyName					= "${var.mfddev}"
    iamInstanceProfile   	= "${var.iamInstanceProfile}"
    userData             	= "${data.template_file.default_userdata.rendered}"
    securityGroups			=  ["${aws_security_group.managementTraffic.id}",
    ]
    terminProtect			= false
    addStatusCheck			= true 
#	topicArn			   	= "arn:aws:sns:eu-west-2:313533373455:ProdEc2Alert" #"${aws_sns_topic.ec2.arn}"
    rootVolumeType   		= "gp2"
    rootVolumeSize   		= "50"
	nameTag               	= "DDEVOPAWSWIN01"
	environmentTag        	= "${var.envTypeTop}"
	environmentNameTag    	= "${var.envNameTop}"
	projectOrServiceTag   	= "mfd"
	roleTag               	= "webservermfd"
	businessUnitTag       	= "nordicUnit"
	departmentTag         	= "nordicDept"
	costCodeTag           	= "94032060"
	powerOffCOB			 	= "Yes" 
} 

module "ec2-win02" {
    source					= "..\\..\\modules\\ec2"  
    amiId					= "ami-8f41a3e8"  
    instanceType			= "t2.micro"
	envName          		= "${var.envNameTop}"
    subnetId				= "${module.vpc.privateSubnetIds[0]}"
	availabilityZone		= "eu-west-2a"
    keyName					= "${var.mfddev}"
    iamInstanceProfile   	= "${var.iamInstanceProfile}"
    userData             	= "${data.template_file.default_userdata.rendered}"
    securityGroups			=  ["${aws_security_group.managementTraffic.id}",
    ]
    terminProtect			= false
    addStatusCheck			= true 
#	topicArn			   	= "arn:aws:sns:eu-west-2:313533373455:ProdEc2Alert" #"${aws_sns_topic.ec2.arn}"
    rootVolumeType   		= "gp2"
    rootVolumeSize   		= "50"
	nameTag               	= "DDEVOPAWSWIN02"
	environmentTag        	= "${var.envTypeTop}"
	environmentNameTag    	= "${var.envNameTop}"
	projectOrServiceTag   	= "mfd"
	roleTag               	= "webservermfd"
	businessUnitTag       	= "nordicUnit"
	departmentTag         	= "nordicDept"
	costCodeTag           	= "94032060"
	powerOffCOB			 	= "No" 
} 





###DC Non Moduled for private IP and custom AMI
#resource "aws_instance" "dc01" {
#  ami           = "ami-e2decc86"
#  instance_type = "t2.micro"
#  key_name      = "mfd-dev"
#  subnet_id     = "subnet-bab903c1"
#  private_ip    = "20.200.33.165"
#  vpc_security_group_ids = ["sg-f316419a"]  
#   tags {
#        Name = "DMFDAWSDC01"
#    }
#  }
#
#resource "aws_eip" "ip" {
#    instance = "${aws_instance.dc01.id}"
#}



#Management Traffic Security Group
resource "aws_security_group" "managementTraffic" {
  name = "${var.envNameTop}-ManagementTraffic"
	description = "Allows managemnent traffic from central VPC"
  vpc_id     = "${module.vpc.vpcId}"
  
  tags {
    Environment = "${var.envNameTop}"
  }
}

resource "aws_security_group_rule" "allowAllFromMGMTWorkstation" {
	type      = "ingress"
	from_port = 0
	to_port   = 65535
	protocol  = "-1"
  security_group_id = "${aws_security_group.managementTraffic.id}"
  cidr_blocks = ["80.5.30.63/32",
				 "82.38.91.134/32",
				 "83.231.170.196/32"]
}

resource "aws_security_group_rule" "egress" {
	type      = "egress"
	from_port = 0
	to_port   = 65535
	protocol  = "-1"
  security_group_id = "${aws_security_group.managementTraffic.id}"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allowAllFromVpcToDc" {
	type      = "ingress"
	from_port = 0
	to_port   = 65535
	protocol  = "-1"
  security_group_id = "${aws_security_group.managementTraffic.id}"
  cidr_blocks = ["20.200.32.0/21"]
}

resource "aws_security_group_rule" "allowAllFromVpcToOct" {
	type      = "ingress"
	from_port = 0
	to_port   = 65535
	protocol  = "-1"
  security_group_id = "${aws_security_group.managementTraffic.id}"
  cidr_blocks = ["20.200.0.0/21"]
}





	
 

