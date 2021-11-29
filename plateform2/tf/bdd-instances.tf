# resource "aws_instance" "bdd-master" {

#   ami           = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.prod-subnet-public-3.id

#   # Security Group
#   vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

#   # the Public SSH key
#   # key_name = aws_key_pair.soar-key-pair.id

#   # connection {
#   #   user        = var.EC2_USER
#   #   private_key = file("${var.PRIVATE_KEY_PATH}")
#   # }

#   tags = {
#     Name = "bdd-master"
#   }
# }

# resource "aws_instance" "bdd-slave" {

#   ami           = lookup(var.AMI, var.AWS_REGION)
#   instance_type = "t2.micro"

#   # VPC
#   subnet_id = aws_subnet.prod-subnet-public-3.id

#   # Security Group
#   vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

#   # the Public SSH key
#   # key_name = aws_key_pair.soar-key-pair.id

#   # connection {
#   #   user        = var.EC2_USER
#   #   private_key = file("${var.PRIVATE_KEY_PATH}")
#   # }

#   tags = {
#     Name = "bdd-slave"
#   }
# }

# # resource "aws_key_pair" "soar-key-pair" {
# #   key_name   = "soar-key-pair"
# #   public_key = file(var.PUBLIC_KEY_PATH)
# # }
