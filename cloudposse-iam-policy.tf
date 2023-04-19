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
