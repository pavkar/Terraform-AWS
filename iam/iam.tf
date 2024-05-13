# Creating IAM policies S3List, S3Create, and S3Delete for each user
locals {
  users_and_policies = {
    UserS3List = {
      name      = "S3List"
      actions   = ["s3:ListAllMyBuckets"]
      resources = ["*"]
    }
    UserS3Create = {
      name      = "S3Create"
      actions   = ["s3:CreateBucket"]
      resources = ["*"]
    }
    UserS3Delete = {
      name      = "S3Delete"
      actions   = ["s3:DeleteBucket"]
      resources = ["*"]
    }
  }
}

# Creating IAM users
resource "aws_iam_user" "test_users" {
  for_each = local.users_and_policies

  name = each.value.name
  path = "/test-users/"

  tags = {
    Terraform = "true"
  }

}

# Creating IAM policies S3List, S3Create, and S3Delete
data "aws_iam_policy_document" "user_policy_document" {
  for_each = local.users_and_policies

  statement {
    actions   = each.value.actions
    resources = each.value.resources
  }
}

resource "aws_iam_policy" "user_policy" {
  for_each = local.users_and_policies

  name        = each.value.name + "Policy"
  description = "Policy for ${each.value.name}"
  policy      = data.aws_iam_policy_document.user_policy_document[each.key].json
}

# Attaching IAM policies to IAM users
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each = local.users_and_policies

  user       = aws_iam_user.test_users[each.key].name
  policy_arn = aws_iam_policy.user_policy[each.key].arn
}

# Creating IAM access keys
resource "aws_iam_access_key" "user_key" {
  for_each = local.users_and_policies

  user = aws_iam_user.test_users[each.key].name
}

# Creating IAM policy to allow each user to read their own secret key
data "aws_iam_policy_document" "user_secret_access_policy_document" {
  for_each = local.users_and_policies

  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.user_secret[each.key].arn]
  }
}

resource "aws_iam_policy" "user_secret_access_policy" {
  for_each = local.users_and_policies

  name        = each.value.name + "SecretAccessPolicy"
  description = "Policy to allow ${each.value.name} to read their own secret key"
  policy      = data.aws_iam_policy_document.user_secret_access_policy_document[each.key].json
}

# Attaching IAM policy to IAM users
resource "aws_iam_user_policy_attachment" "user_secret_access_policy_attachment" {
  for_each = local.users_and_policies

  user       = aws_iam_user.test_users[each.key].name
  policy_arn = aws_iam_policy.user_secret_access_policy[each.key].arn
}
