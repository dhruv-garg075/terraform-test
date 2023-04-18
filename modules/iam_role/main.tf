resource "aws_iam_role" "TerraformTestRole" {
  provider           = aws.dev
  name               = "TerraformTestRole"
  assume_role_policy = jsonencode(
        {
            Statement = [
                {
                    Action    = "sts:AssumeRole"
                    Effect    = "Allow"
                    Principal = {
                        Service = "ec2.amazonaws.com"
                    }
                },
            ]
            Version   = "2012-10-17"
        }
    )
  managed_policy_arns = [
    "arn:aws:iam::${var.account_id}:policy/service-role/s3crr_for_dhruv-bucket-original_99be4e",
    "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
  ]
  inline_policy {
        name   = "TestInlinePolicy"
        policy = jsonencode(
            {
                Statement = [
                    {
                        Action   = [
                            "s3:ListStorageLensConfigurations",
                            "s3:ListAccessPointsForObjectLambda",
                            "s3:ListBucketMultipartUploads",
                            "s3:ListAllMyBuckets",
                            "s3:ListAccessPoints",
                            "s3:ListJobs",
                            "s3:ListBucketVersions",
                            "s3:ListBucket",
                            "s3:ListMultiRegionAccessPoints",
                            "s3:ListMultipartUploadParts",
                        ]
                        Effect   = "Allow"
                        Resource = "*"
                        Sid      = "VisualEditor0"
                    },
                ]
                Version   = "2012-10-17"
            }
        )
    }
}
