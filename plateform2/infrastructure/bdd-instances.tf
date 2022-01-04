# resource "aws_instance" "db-manager" {

#   ami           = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.prod-public-subnet-1.id

#   # Security Group
#   vpc_security_group_ids = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

#   # Specify private ip
#   private_ip = "10.0.1.43"

#   # The Public SSH key
#   key_name = aws_key_pair.webserver-key.key_name

#   # Installation script
#   user_data = file("../database/db-manager.sh")

#   connection {
#     user        = var.EC2_USER
#     private_key = tls_private_key.webserver-private-key.private_key_pem
#   }

#   tags = {
#     Name = "db-manager"
#   }
# }

# resource "aws_instance" "db-node1" {

#   ami           = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.prod-public-subnet-1.id

#   # Security Group
#   vpc_security_group_ids = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

#   # Specify private ip
#   private_ip = "10.0.1.54"

#   # The Public SSH key
#   key_name = aws_key_pair.webserver-key.key_name

#   # Installation script
#   user_data = file("../database/db-node1.sh")

#   connection {
#     user        = var.EC2_USER
#     private_key = tls_private_key.webserver-private-key.private_key_pem
#   }

#   tags = {
#     Name = "db-node1"
#   }
# }

# resource "aws_instance" "db-node2" {

#   ami           = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.prod-public-subnet-2.id

#   # Security Group
#   vpc_security_group_ids = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

#   # Specify private ip
#   private_ip = "10.0.2.55"

#   # The Public SSH key
#   key_name = aws_key_pair.webserver-key.key_name

#   # Installation script
#   user_data = file("../database/db-node2.sh")

#   connection {
#     user        = var.EC2_USER
#     private_key = tls_private_key.webserver-private-key.private_key_pem
#   }

#   tags = {
#     Name = "db-node2"
#   }
# }
