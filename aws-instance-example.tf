resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-01718400c2741bdb3"]
   key_name               = "Linux_Terraform-Chef"     
   
   user_data = <<-EOF
		#!/bin/bash
                yum update -y
		yum install -y httpd.x86_64
		systemctl start httpd.service
		systemctl enable httpd.service
		echo "Hello World from $(hostname -f)" > /var/www/html/index.html
	EOF
}
