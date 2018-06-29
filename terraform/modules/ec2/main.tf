variable "diskDeviceNames" {
  type = "list"
  default = [
    "xvdf",
    "xvdg",
    "xvdh",
    "xvdi",
    "xvdj",
    "xvdk",
    "xvdl",
    "xvdm",
    "xvdn",
    "xvdo",
    "xvdp",
    "xvdq",
    "xvdr",
    "xvds",
    "xvdt",
    "xvdu",
    "xvdv",
    "xvdw",
    "xvdx",
    "xvdy",
    "xvdz"
  ]
}

resource "aws_instance" "instance" {
  ami 		             = "${var.amiId}"
  instance_type          = "${var.instanceType}"
  subnet_id   	         = "${var.subnetId}"
  key_name               = "${var.keyName}"
  iam_instance_profile   = "${var.iamInstanceProfile}"
  user_data              = "${var.userData}" 
  source_dest_check      = "${var.sourceDestCheck}"
  ebs_optimized          = "${var.ebsOptimized}"
  vpc_security_group_ids = ["${var.securityGroups}"]
  associate_public_ip_address  = true
  disable_api_termination = "${var.terminProtect}"
  
  root_block_device {
  	volume_type = "${var.rootVolumeType}"
  	volume_size = "${var.rootVolumeSize}"
  }
  
  tags {
    Name    		         = "${var.nameTag}"
    uProjectOrService    = "${var.projectOrServiceTag}"
    uRole                = "${var.roleTag}"
    oEnvironment         = "${var.environmentTag}"
    rEnvironmentName     = "${var.environmentNameTag}"
    rBusinessUnit        = "${var.businessUnitTag}"
    rDepartment          = "${var.departmentTag}"
    rPONumber            = "${var.costCodeTag}"
	oPowerOffCOB		 = "${var.powerOffCOB}"
  }
  
  lifecycle {
    ignore_changes = [
      "user_data",
      "ami"
    ]
  }  
}

resource "aws_ebs_volume" "volume" {
  count              = "${length(var.diskSizes)}"
  size               = "${var.diskSizes[count.index]}"
  availability_zone  = "${var.availabilityZone}"
  encrypted          = "true"
  type               = "gp2"

  tags {
    uProjectorService    = "${var.projectOrServiceTag}"
    oEnvironment         = "${var.environmentTag}"
    rEnvironmentName     = "${var.environmentNameTag}"
    rBusinessUnit        = "${var.businessUnitTag}"
    rDepartment          = "${var.departmentTag}"
    rPONumber	         = "${var.costCodeTag}"
  }
}

resource "aws_volume_attachment" "attachment" {
  count       = "${length(var.diskSizes)}"
  device_name = "${var.diskDeviceNames[count.index]}"
  instance_id = "${aws_instance.instance.id}"
  volume_id   = "${element(aws_ebs_volume.volume.*.id, count.index)}"
}

resource "aws_eip" "eip" {
  count     = "${var.elasticIpYesOrNo}"
  instance  = "${element(aws_instance.instance.*.id, count.index)}"
  vpc       = true
}

#resource "aws_cloudwatch_metric_alarm" "instance_status" {
#  count = "${var.addStatusCheck ? 1 : 0}"
#  alarm_name          = "${var.nameTag}-Status-Check"
#  comparison_operator = "GreaterThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "StatusCheckFailed"
#  namespace           = "AWS/EC2"
#  period              = "60"
#  statistic           = "Maximum"
#  threshold           = "1"
#  alarm_actions			= ["${var.topicArn}"
#							]
#  dimensions {
#	InstanceId			 = 	"${aws_instance.instance.id}"	
#  }
#  alarm_description = "EC2 Status Alarm"
#  actions_enabled	= "true"
#}