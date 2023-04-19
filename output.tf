output "policy" {
  value = data.aws_iam_policy_document.inline_policy.json
}

output "policy_name" {
  value = resource.aws_iam_policy.test_managed_policy.name
}
