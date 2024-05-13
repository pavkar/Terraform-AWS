variable "ssh_cidr_block" {
  type        = string
  description = "The IP address that should have access to the SSH port"
}

variable "http_cidr_block" {
  type        = string
  description = "The IP address that should have access to the HTTP port"
}

variable "egress_cidr_block" {
  type        = string
  description = "The IP address that should have access to all outbound traffic"
}

variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
}
variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the EC2 instance"
}
