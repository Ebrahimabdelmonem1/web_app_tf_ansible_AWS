resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_security_group" "my_sg" {
  vpc_id      = aws_vpc.my_VPC.id
  name        = "my-security-group"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}


## Launch an EC2 Instance in the Public 1 Subnet
#resource "aws_instance" "public1_instance" {
#  ami                    = "ami-0ad554caf874569d2"
#  instance_type          = "t2.micro"
#  subnet_id              = aws_subnet.public_sub1.id
#  key_name               = aws_key_pair.my_key.key_name
#  vpc_security_group_ids = [aws_security_group.my_sg.id]

#  # Ensure a public IP is associated with this instance
#  associate_public_ip_address = true

#  tags = {
#    Name = "public1_ec2"
#  }
#}


# Launch an EC2 Instance in the Private 1 Subnet
resource "aws_instance" "private1_instance" {
  ami                    = "ami-0ad554caf874569d2"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_sub1.id
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2-bastion-sg.id]
#  user_data              = file("nginx.sh")



  tags = {
    Name = "private1_ec2"
  }
}





# Launch an EC2 Instance in the Public 2 Subnet
#resource "aws_instance" "public2_instance" {
#  ami                    = "ami-0ad554caf874569d2"
#  instance_type          = "t2.micro"
#  subnet_id              = aws_subnet.public_sub2.id
#  key_name               = aws_key_pair.my_key.key_name
#  vpc_security_group_ids = [aws_security_group.my_sg.id]

#  # Ensure a public IP is associated with this instance
#  associate_public_ip_address = true

#  tags = {
#    Name = "public2_ec2"
#  }
#}


# Launch an EC2 Instance in the Private 2 Subnet
resource "aws_instance" "private2_instance" {
  ami                    = "ami-0ad554caf874569d2"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_sub2.id
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2-bastion-sg.id]
#  user_data              = file("nginx.sh")


  tags = {
    Name = "private2_ec2"
  }
}


