# Modify the existing security group to allow inbound traffic on port 8080 from specific IPs
resource "aws_security_group" "allow_ssh_and_http" {
  name        = "allow_ssh_and_http"
  description = "Allow SSH and HTTP inbound traffic from specific IPs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.http_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_block]
  }
}

# Modify the existing EC2 instance to use the new security group
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh_and_http.id]

  tags = {
    Name = "Terraform"
  }
}