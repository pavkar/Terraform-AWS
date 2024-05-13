resource "aws_secretsmanager_secret" "user_secret" {
  for_each = local.users_and_policies

  name = each.value.name + "Secret"
  tags = {
    Terraform = "true"
  }
}

resource "aws_secretsmanager_secret_version" "user_secret_version" {
  for_each = local.users_and_policies

  secret_id = aws_secretsmanager_secret.user_secret[each.key].id
  secret_string = jsonencode({
    access_key = aws_iam_access_key.user_key[each.key].id
    secret_key = aws_iam_access_key.user_key[each.key].secret
  })
}
