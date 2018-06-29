#################################################################################################################
### Variables

### Puppet
# EC2 Userdata
puppetDlLink                = "https://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.3.3-x64.msi"
puppetS3KeyName             = "ina-easyjet-puppet-wip.zip"

# SSM Parameter Store
puppetKeysSsmParamLoc       = "automation/puppet/keys"
puppetPrivateKeySsmParamLoc = "hieraeyaml.private"
puppetPublicKeySsmParamLoc  = "hieraeyaml.public"

awsRegionTop                = "eu-west-2"

commonTags = {
  oEnvironment      = "dev"
  rEnvironmentName  = "INA-EASYJET-DEV"
  rBusinessUnit     = "INA"
  rDepartment       = "INA"
  rPONumber         = "94030750"
  uProjectOrService = "INA EASYJET"
  uRole             = "Undefined"
}

