data "aws_iam_policy_document" "inline_policy" {
  statement {
    sid       = "VisualEditor0"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:ListStorageLensConfigurations",
      "s3:ListAccessPointsForObjectLambda",
      "s3:ListBucketMultipartUploads",
      "s3:ListAllMyBuckets",
      "s3:ListAccessPoints",
      "s3:ListJobs",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:ListMultiRegionAccessPoints",
      "s3:ListMultipartUploadParts"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["arn:aws:s3:::bucketname"]
    effect    = "Allow"
  }
}

module "role" {
  source = "cloudposse/iam-role/aws"
  version     = "0.17.0"
  providers = {
    aws = aws.dev
  }

  enabled   = true
  name      = "TerraformTestRole-cloudposse"

  policy_description = "Testing Cloudposse"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  assume_role_actions = ["sts:AssumeRole"]
  principals = {
    Service = ["ec2.amazonaws.com"]
  }

  policy_documents = [
    data.aws_iam_policy_document.inline_policy.json,
    data.aws_iam_policy_document.base.json
  ]
  
  managed_policy_arns = [
    "arn:aws:iam::122838670202:policy/service-role/s3crr_for_dhruv-bucket-original_99be4e",
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
  ]
}
