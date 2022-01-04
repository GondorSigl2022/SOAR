resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "prod-igw"
  }
}

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.prod-igw.id
  }

  tags = {
    Name = "prod-public-crt"
  }
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.prod-public-subnet-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}

resource "aws_route_table_association" "prod-crta-public-subnet-2" {
  subnet_id      = aws_subnet.prod-public-subnet-2.id
  route_table_id = aws_route_table.prod-public-crt.id
}

module "alb-front" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "elb-front"

  load_balancer_type = "application"

  vpc_id = aws_vpc.prod-vpc.id
  subnets = [
    aws_subnet.prod-public-subnet-1.id,
    aws_subnet.prod-public-subnet-2.id
  ]

  security_groups = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

module "alb-back" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "elb-back"

  load_balancer_type = "application"

  vpc_id = aws_vpc.prod-vpc.id
  subnets = [
    aws_subnet.prod-public-subnet-1.id,
    aws_subnet.prod-public-subnet-2.id
  ]

  security_groups = [aws_security_group.http-allowed.id, aws_security_group.ssh-allowed.id]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
