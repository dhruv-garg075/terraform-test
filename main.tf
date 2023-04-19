resource "aws_iam_policy" "test_managed_policy" {
  name = "TestManagedPolicy"
  policy = file("../managedpolicy.json")
}
