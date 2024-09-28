output "Bastion1_ip"{
 value = aws_instance.ec2-bastion-host1.public_ip
}
output "private1_instance_ip"{
 value = aws_instance.private1_instance.private_ip
}
output "Bastion2_ip"{
 value = aws_instance.ec2-bastion-host2.public_ip
}
output "private2_instance_ip"{
 value = aws_instance.private2_instance.private_ip
}

output "load_balancer_dns" {
  value = aws_lb.my_lb.dns_name
}