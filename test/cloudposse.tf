module "policy" {
  source = "../"
}

module "managed_iam_policy" {
  source = "cloudposse/iam-policy/aws"
  version = "0.4.0"
  providers = {
    aws = aws.dev
  }
  enabled = true
  name = "test-policy-cloudposse"
  
  iam_source_policy_documents = [
    "${module.policy.all_access}"
  ]
}

module "dev_iam_role" {
  depends_on = [module.managed_iam_policy]
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
    module.policy.policy,
    module.policy.policy1
  ]
  
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess",
    "${module.managed_iam_policy.policy_arn}"
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
    module.policy.policy
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
  ]
}

