variable "cidr_block" {}
variable "vpcId" {}
variable "igwId" {}
variable "envName" {}
variable "natGwId" {}
#variable "vgwId" {} 

variable "privateSubnetIds" {
  type = "list"
}

variable "publicSubnetIds" {
  type = "list"
}




