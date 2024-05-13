variable "aws_regions" {
  description = "The list of AWS regions to enable Security Hub"
  type        = list(string)
  default = [
    "eu-central-1",
  ]
}

variable "standards_arns" {
  type        = list(string)
  description = "The list of standards ARNs to enable"
  default = [
    "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0",
    "arn:aws:securityhub:eu-central-1::standards/cis-aws-foundations-benchmark/v/1.4.0",
    "arn:aws:securityhub:eu-central-1::standards/aws-foundational-security-best-practices/v/1.0.0",
    "arn:aws:securityhub:eu-central-1::standards/pci-dss/v/3.2.1",
    "arn:aws:securityhub:eu-central-1::standards/nist-800-53/v/5.0.0"
  ]
}
