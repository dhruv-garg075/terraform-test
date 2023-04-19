resource "aws_iam_policy" "test_managed_policy" {
  name     = "TestManagedPolicy"
  policy   = file("../modules/iam_policy/managedpolicy.json")
}

