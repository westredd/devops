variable "amiId" {}
#variable "instanceCount" {}
variable "subnetId" {}
variable "availabilityZone" {}
variable "instanceType" {}
variable "envName" {}
variable "rootVolumeType" {}
variable "rootVolumeSize" {}
variable "keyName" {}
variable "terminProtect" {} 
variable "addStatusCheck" {}
#variable "topicArn" {}


variable "sourceDestCheck" {
  default = "true"
}

variable "ebsOptimized" {
  default = "false"
}

variable "userData" {
  default = ""
}

variable "iamInstanceProfile" {
  type = "string"
  default = ""
}

variable "securityGroups" {
  type = "list"
  description = "A list of security group IDs to add these instances to"
  default = []
}

variable "diskSizes" {
  type = "list"
  description = "A list of disk sizes to create and attach to the instances"
  default = []
}

variable "elasticIpYesOrNo" {
  description = "Creates an elastic IP if set to 1"
  default = "0"
}

variable "nameTag" {}
variable "environmentTag" {}
variable "environmentNameTag" {}
variable "projectOrServiceTag" {}
variable "roleTag" {}
variable "businessUnitTag" {}
variable "departmentTag" {}
variable "costCodeTag" {}
variable "powerOffCOB" {}

