resource "aws_securityhub_finding_aggregator" "monitored_regions" {
  linking_mode      = "SPECIFIED_REGIONS"
  specified_regions = var.aws_regions
}

resource "aws_securityhub_organization_configuration" "master" {
  auto_enable = true
}