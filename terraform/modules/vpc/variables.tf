variable "vpcCidr" {}
variable "envName" {}


variable "publicSubnets" {
  type = "list"
}

variable "privateSubnets" {
  type = "list"
}

variable "availabilityZones" {
  type = "list"
}