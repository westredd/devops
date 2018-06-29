resource "aws_instance" "ec2-dc01" {
  ami           = "ami-bb4859df
  instance_type = "t2.micro"
  key_name      = "mfd-dev"
  subnet_id     = "	
  subnet-bab903c1"
  private_ip    = "20.200.33.22"
  vpc_security_group_ids = ["sg-f316419a"]  
   tags {
        Name = "DMFDAWSDC01"
	Project = "mfd"
    }
  }

resource "aws_eip" "ip" {
    instance = "${aws_instance.ec2-dc012.id}"
}