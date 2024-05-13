# Disabling security hub (except for the root account)
data "aws_iam_policy_document" "block_disable_securityhub" {
  statement {
    sid       = "DenyDisableSecurityHub"
    effect    = "Deny"
    actions   = [
      "securityhub:DisableSecurityHub"
    ]
    resources = ["*"]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::<account-id>:root"]
    }
  }
}

resource "aws_organizations_policy" "block_disable_securityhub" {
  name     = "block_disable_securityhub"
  content  = data.aws_iam_policy_document.block_disable_securityhub.json
  type     = "SERVICE_CONTROL_POLICY"
}

# Disabling CloudTrail (except for the root account)
data "aws_iam_policy_document" "block_disable_cloudtrail" {
  statement {
    sid       = "DenyDisableCloudTrail"
    effect    = "Deny"
    actions   = [
      "cloudtrail:StopLogging"
    ]
    resources = ["*"]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::<account-id>:root"]
    }
  }
}

resource "aws_organizations_policy" "block_disable_cloudtrail" {
  name     = "block_disable_cloudtrail"
  content  = data.aws_iam_policy_document.block_disable_cloudtrail.json
  type     = "SERVICE_CONTROL_POLICY"
}

# Exposing CloudTrail S3 bucket publicly
data "aws_iam_policy_document" "block_public_cloudtrail" {
  statement {
    sid       = "DenyPublicAccessToCloudTrailBucket"
    effect    = "Deny"
    actions   = [
      "s3:PutBucketAcl",
      "s3:PutBucketPolicy"
    ]
    resources = ["arn:aws:s3:::*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["public-read", "public-read-write"]
    }
  }
}

resource "aws_organizations_policy" "block_public_cloudtrail" {
  name     = "block_public_cloudtrail"
  content  = data.aws_iam_policy_document.block_public_cloudtrail.json
  type     = "SERVICE_CONTROL_POLICY"
}