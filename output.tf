output "policy" {
  value = data.aws_iam_policy_document.inline_policy.json
}

output "policy1" {
  value = data.aws_iam_policy_document.base.json
}

output "all_access" {
  value = data.aws_iam_policy_document.all-resources-dev-access.json
}
