# Define the policy
data "aws_iam_policy_document" "s3_list_policy" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}

# Create test user 1
resource "aws_iam_user" "test_user1" {
  name = var.user_name
}

resource "aws_iam_access_key" "test_user1_key" {
  user = aws_iam_user.test_user1.name
}

resource "aws_iam_user_policy" "test_user1_policy" {
  name   = var.policy_name
  user   = aws_iam_user.test_user1.name
  policy = data.aws_iam_policy_document.s3_list_policy.json
}

# Create test user 2
resource "aws_iam_user" "test_user2" {
  name = var.user_name_2
}

resource "aws_iam_access_key" "test_user2_key" {
  user = aws_iam_user.test_user2.name
}

resource "aws_iam_user_policy" "test_user2_policy" {
  name   = var.policy_name_2
  user   = aws_iam_user.test_user2.name
  policy = data.aws_iam_policy_document.s3_list_policy.json
}