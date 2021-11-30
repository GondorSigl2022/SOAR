resource "tls_private_key" "webserver-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private-key" {
  content         = tls_private_key.webserver-private-key.private_key_pem
  filename        = "webserver-key.pem"
  file_permission = 0400
}

resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = tls_private_key.webserver-private-key.public_key_openssh
}
