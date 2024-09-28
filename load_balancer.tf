resource "aws_lb" "my_lb" {
  #  count              = length(var.subnets-id)
  name               = "devops-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.public_sub1.id, aws_subnet.public_sub2.id]
  #  subnets = var.subnets-id[count.index]
  enable_deletion_protection = false

  #  access_logs {
  #    bucket  = aws_s3_bucket.lb_logs.id
  #    prefix  = "test-lb"
  #    enabled = true
  #  }

  tags = {
    Environment = "production"
  }
}



resource "aws_lb_target_group" "my_tg" {
  name     = "tf-my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_VPC.id


  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
  }


}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}


resource "aws_lb_target_group_attachment" "attach-my-tg" {
#  count            = length(var.instance_id)
  target_group_arn = aws_lb_target_group.my_tg.arn
#  target_id        = var.instance_id[count.index]
    target_id       =  aws_instance.private1_instance.id
  port = 80
}