resource "aws_security_group" "ec2-bastion-sg" {
  description = "EC2 Bastion Host Security Group"
  name = "ec2-bastion-sg"
  vpc_id = aws_vpc.my_VPC.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH
    description = "Open to Public Internet"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "IPv4 route Open to Public Internet"
  }
}



## EC2 Bastion Host Elastic IP
resource "aws_eip" "ec2-bastion-host-eip" {
    vpc = true
    tags = {
    Name = "ec2-bastion-host-eip"
    }
}




resource "aws_instance" "ec2-bastion-host1" {
    ami = "ami-0ad554caf874569d2"
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [ aws_security_group.ec2-bastion-sg.id ]
    subnet_id = aws_subnet.public_sub1.id
    user_data              = file("ansible.sh")
    associate_public_ip_address = true
    #user_data                   = file(var.bastion-bootstrap-script-path)
    root_block_device {
      volume_size = 8
      delete_on_termination = true
      volume_type = "gp2"
      encrypted = true
      tags = {
        Name = "ec2-bastion-host-root-volume-"
      }
    }
    credit_specification {
      cpu_credits = "standard"
    }
    tags = {
        Name = "ec2-bastion-host1"
    }
    lifecycle {
      ignore_changes = [ 
        associate_public_ip_address,
       ]
    }

}



resource "aws_instance" "ec2-bastion-host2" {
    ami = "ami-0ad554caf874569d2"
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [ aws_security_group.ec2-bastion-sg.id ]
    subnet_id = aws_subnet.public_sub1.id
    user_data              = file("ansible.sh")
    associate_public_ip_address = true
    #user_data                   = file(var.bastion-bootstrap-script-path)
    root_block_device {
      volume_size = 8
      delete_on_termination = true
      volume_type = "gp2"
      encrypted = true
      tags = {
        Name = "ec2-bastion-host-root-volume-"
      }
    }
    credit_specification {
      cpu_credits = "standard"
    }
    tags = {
        Name = "ec2-bastion-host2"
    }
    lifecycle {
      ignore_changes = [ 
        associate_public_ip_address,
       ]
    }

}
