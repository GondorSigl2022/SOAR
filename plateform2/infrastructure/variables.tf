variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMI" {
  type = map(string)

  default = {
    # AMI Ubuntu
    us-east-1 = "ami-04505e74c0741db8d"
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
