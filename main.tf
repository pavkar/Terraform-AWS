module "securityhub" {
  source = "securityhub"
}

module "cloudtrail" {
  source = "cloudtrail"
}

module "iam" {
  source = "iam"
}

module "organization" {
  source = "organization"

  # Needs to be changed for correct values
  organization_admin_role = "AdminRole"
  root_account            = "123456789"
}

module "ec2" {
  source = "ec2"

  # Needs to be changed for correct values
  key_name          = "my-key"
  ami_id            = "ami-1234556789"
  ssh_cidr_block    = ""
  http_cidr_block   = ""
  egress_cidr_block = ""
}
