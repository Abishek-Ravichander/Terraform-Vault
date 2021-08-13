resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-01718400c2741bdb3"]
   key_name               = "Linux_Terraform-Chef" 
   iam_instance_profile =   "myManagedInstanceRole"
   user_data = <<-EOF
		#!/bin/bash
                sudo mkdir /tmp/ssm
		cd /tmp/ssm
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
		sudo dpkg -i amazon-ssm-agent.deb
		sudo systemctl enable amazon-ssm-agent
		rm amazon-ssm-agent.deb
	EOF

  
}
