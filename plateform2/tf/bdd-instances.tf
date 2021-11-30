resource "aws_instance" "bdd-master" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.prod-public-subnet-3.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.webserver-key.key_name

  connection {
    user        = var.EC2_USER
    private_key = tls_private_key.webserver-private-key.private_key_pem
  }

  tags = {
    Name = "bdd-master"
  }
}

resource "aws_instance" "bdd-slave" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.prod-public-subnet-3.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH key
  key_name = aws_key_pair.webserver-key.key_name

  connection {
    user        = var.EC2_USER
    private_key = tls_private_key.webserver-private-key.private_key_pem
  }

  tags = {
    Name = "bdd-slave"
  }
}
