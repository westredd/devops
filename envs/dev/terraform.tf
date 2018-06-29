#Modules
module "vpc" {
  source            = "..\\..\\modules\\vpc"  
  envName           = "${var.envNameTop}"
  vpcCidr           = "20.200.32.0/21"
}