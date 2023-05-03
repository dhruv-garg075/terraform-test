resource "aws_iam_policy" "list_roles_policy" {
  name        = "ListRoles"
  path        = "/"
  description = "Policy to list all IAM roles"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ListRoles",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "azuread_provisioner" {
  name = "AzureAD-Provisioner"
}

resource "aws_iam_user_policy_attachment" "azuread_policy_attach" {
  user       = aws_iam_user.azuread_provisioner.name
  policy_arn = aws_iam_policy.list_roles_policy.arn
}

resource "aws_iam_access_key" "azuread" {
  user    = aws_iam_user.azuread_provisioner.name
}

output "secret" {
  value = aws_iam_access_key.azuread.encrypted_secret
}
