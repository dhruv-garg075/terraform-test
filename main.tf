terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0" 
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::430288206927:role/TerraformTestRole"
    session_name = "TestSession"
    external_id  = "EXTERNAL_ID"
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
      sid    = "test1"
      actions = [
                "acm:DescribeCertificate",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "shield:CreateProtection",
                "elasticloadbalancing:ModifyRule",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:DescribeRules",
                "ec2:DescribeSubnets",
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "waf-regional:AssociateWebACL",
                "ec2:DescribeAddresses",
                "ec2:DeleteTags",
                "shield:DescribeProtection",
                "shield:DeleteProtection",
                "elasticloadbalancing:RemoveListenerCertificates",
                "elasticloadbalancing:RemoveTags",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DescribeListeners",
                "ec2:DescribeNetworkInterfaces",
                "ec2:CreateSecurityGroup",
                "acm:ListCertificates"
               ]
      resources = [
        "*" 
      ]
    }
}

data "aws_iam_policy_document" "s3_readwrite" {
  statement {
    sid = "s3"

    actions = [
      "s3:*Object",
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "single_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.instance_assume_role_policy.json,
    data.aws_iam_policy_document.s3_readwrite.json
  ]
  statement {
    sid = "abc"
    actions = ["s3:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "asg_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

  }
}

resource "aws_iam_role" "TestDevRole-Terraform" {
  name               = "TestDevRole-Terraform"
  assume_role_policy = data.aws_iam_policy_document.asg_assume_role_policy.json
  inline_policy {
    name   = "test-policy"
    policy = data.aws_iam_policy_document.single_policy.json
  }
}

resource "aws_iam_role" "TestDevRole" {
    name                  = "TestDevRole"
    assume_role_policy    = jsonencode(
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
    managed_policy_arns   = [
        "arn:aws:iam::430288206927:policy/ALBIngressControllerIAMPolicy",
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
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

