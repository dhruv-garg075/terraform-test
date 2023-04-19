resource "aws_iam_policy" "test_managed_policy" {
  provider = aws.dev
  name     = "TestManagedPolicy"
  policy   = file("../modules/iam_policy/managedpolicy.json")

}

