# resource "aws_launch_configuration" "front" {
#   name_prefix = "front-"

#   image_id      = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   security_groups             = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.webserver-key.key_name

#   user_data = file("application-scripts/front.sh")

#   lifecycle {
#     create_before_destroy = true
#   }

#   connection {
#     user        = var.EC2_USER
#     private_key = tls_private_key.webserver-private-key.private_key_pem
#   }
# }

# resource "aws_autoscaling_group" "front" {
#   name = "${aws_launch_configuration.front.name}-asg"

#   min_size         = 2
#   desired_capacity = 2
#   max_size         = 4

#   health_check_type = "ELB"
#   target_group_arns = module.alb.target_group_arns

#   launch_configuration = aws_launch_configuration.front.name

#   enabled_metrics = [
#     "GroupMinSize",
#     "GroupMaxSize",
#     "GroupDesiredCapacity",
#     "GroupInServiceInstances",
#     "GroupTotalInstances"
#   ]

#   metrics_granularity = "1Minute"

#   vpc_zone_identifier = [
#     aws_subnet.prod-public-subnet-1.id,
#     aws_subnet.prod-public-subnet-2.id
#   ]

#   # Required to redeploy without an outage.
#   lifecycle {
#     create_before_destroy = true
#   }

#   tag {
#     key                 = "Name"
#     value               = "front"
#     propagate_at_launch = true
#   }

# }
