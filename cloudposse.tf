module "dev_iam_role" {
  source = "cloudposse/iam-role/aws"
  version     = "0.17.0"
  providers = {
    aws = aws.dev
  }

  enabled   = true
  name      = "TerraformTestRole-cloudposse"

  policy_description = "Testing Cloudposse"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  assume_role_actions = ["sts:AssumeRoleWithSAML"]
  principals = {
    Federated = ["arn:aws:iam::${var.dev_account_id}:saml-provider/OneLogin"]
  }

  policy_documents = [
    data.aws_iam_policy_document.inline_policy.json,
    data.aws_iam_policy_document.base.json
  ]
  
  managed_policy_arns = [
    "arn:aws:iam::${var.dev_account_id}:policy/service-role/s3crr_for_dhruv-bucket-original_99be4e",
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
  ]
}

module "prod_iam_role" {
  source = "cloudposse/iam-role/aws"
  version     = "0.17.0"
  providers = {
    aws = aws.prod
  }

  enabled   = true
  name      = "TerraformTestRole-cloudposse"

  policy_description = "Testing Cloudposse"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  assume_role_actions = ["sts:AssumeRoleWithSAML"]
  principals = {
    Federated = ["arn:aws:iam::${var.prod_account_id}:saml-provider/OneLogin"]
  }

  policy_documents = [
    data.aws_iam_policy_document.inline_policy.json,
    data.aws_iam_policy_document.base.json
  ]

  managed_policy_arns = [
    "arn:aws:iam::${var.prod_account_id}:policy/service-role/s3crr_for_dhruv-bucket-original_99be4e",
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
  ]
}

