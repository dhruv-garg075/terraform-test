output "policy" {
  value = data.aws_iam_policy_document.inline_policy.json
}
