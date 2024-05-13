# Disabling security hub (except for the root account)
data "aws_iam_policy_document" "block_disable_securityhub" {
  statement {
    sid    = "DenyDisableSecurityHub"
    effect = "Deny"
    actions = [
      "securityhub:DeleteInvitations",
      "securityhub:DisableSecurityHub",
      "securityhub:DisassociateFromMasterAccount",
      "securityhub:DeleteMembers",
      "securityhub:DisassociateMembers"
    ]
    resources = ["*"]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${var.root_account}:root", "arn:aws:iam::${var.root_account}:role/${var.organization_admin_role}"]
    }
  }
}

resource "aws_organizations_policy" "block_disable_securityhub" {
  name    = "block_disable_securityhub"
  content = data.aws_iam_policy_document.block_disable_securityhub.json
  type    = "SERVICE_CONTROL_POLICY"
}

# Disabling CloudTrail (except for the root account)
data "aws_iam_policy_document" "block_disable_cloudtrail" {
  statement {
    sid    = "DenyDisableCloudTrail"
    effect = "Deny"
    actions = [
      "cloudtrail:StopLogging",
      "cloudtrail:DeleteTrail"
    ]
    resources = ["*"]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${var.root_account}:root", "arn:aws:iam::${var.root_account}:role/${var.organization_admin_role}"]
    }
  }
}

resource "aws_organizations_policy" "block_disable_cloudtrail" {
  name    = "block_disable_cloudtrail"
  content = data.aws_iam_policy_document.block_disable_cloudtrail.json
  type    = "SERVICE_CONTROL_POLICY"
}

# Exposing CloudTrail S3 bucket publicly
data "aws_iam_policy_document" "block_public_cloudtrail" {
  statement {
    sid    = "DenyPublicAccessToCloudTrailBucket"
    effect = "Deny"
    actions = [
      "s3:PutBucketPublicAccessBlock",
      "s3:PutAccountPublicAccessBlock"
    ]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_organizations_policy" "block_public_cloudtrail" {
  name    = "block_public_cloudtrail"
  content = data.aws_iam_policy_document.block_public_cloudtrail.json
  type    = "SERVICE_CONTROL_POLICY"
}