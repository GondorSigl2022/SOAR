variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMI" {
  type = map(string)

  default = {
    us-east-2 = "ami-01685d240b8fbbfeb"
  }

}

# variable "PUBLIC_KEY_PATH" {
#   default = "~/.ssh/soar-key-pair.pub"
# }

# variable "PRIVATE_KEY_PATH" {
#   default = "~/.ssh/soar-key-pair"
# }

variable "EC2_USER" {
  default = "ubuntu"
}
