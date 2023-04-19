output "policy" {
  value = data.aws_iam_policy_document.inline_policy.json
}

output "policy1" {
  value = data.aws_iam_policy_document.base.json
}
