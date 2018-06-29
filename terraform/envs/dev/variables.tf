variable "mfddev" {
	default = "mfd-key"
	}
	
variable "iamInstanceProfile" {
	default = "mfddev-defaultEc2-role"
	}
	
### Variables: Puppet
variable "puppetDlLink" {
  type        = "string"
  description = "The HTTPS URL for downloading the Puppet Agent installer"
}
variable "puppetS3KeyName" {
  type        = "string"
  description = "The S3 keyname for the zip containing the Puppet code"
}
variable "puppetKeysSsmParamLoc" {
  type        = "string"
  description = "The SSM Paramater Store location for Puppet Keys"
}
variable "puppetPrivateKeySsmParamLoc" {
  type        = "string"
  description = "The SSM Paramater Store leaf name for the Puppet hiera-eyaml private key"
}
variable "puppetPublicKeySsmParamLoc" {
  type        = "string"
  description = "The SSM Paramater Store leaf name for the Puppet hiera-eyaml public key"
}	


variable "awsRegionTop" {
	default = "eu-west-2"
	}

	