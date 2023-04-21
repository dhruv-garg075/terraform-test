resource "aws_iam_policy" "test_managed_policy" {
  name     = "TestManagedPolicy"
  policy   = file("managedpolicy.json")
}

module "dev_iam_role" {
  depends_on = [aws_iam_policy.test_managed_policy]
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
    Federated = ["arn:aws:iam::820297181458:saml-provider/OneLogin"]
  }

  assume_role_conditions = [(
    {
      test = "StringEquals"
      variable = "SAML:aud"
      values = ["https://signin.aws.amazon.com/saml"]
    }
  )]

  policy_document_count = 2
  
  policy_documents = [
    data.aws_iam_policy_document.inline_policy.json
  ]
  
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess",
    "arn:aws:iam::${var.dev_account_id}:policy/${aws_iam_policy.test_managed_policy.name}"
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
    Federated = ["arn:aws:iam::820297181458:saml-provider/OneLogin"]
  }

  policy_documents = [
    data.aws_iam_policy_document.inline_policy.json
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess",
    "arn:aws:iam::${var.prod_account_id}:policy/${aws_iam_policy.test_managed_policy.name}"
  ]
}

