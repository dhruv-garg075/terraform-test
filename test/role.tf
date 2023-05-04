resource "aws_iam_role" "test_service_role" {
  provider = aws.prod
  name = "TestServiceRole"
  assume_role_policy = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "test_policy_attach" {
   provider = aws.prod
   role       = "${aws_iam_role.test_service_role.name}"
   for_each = toset([
     "arn:aws:iam::430288206927:policy/ALBIngressControllerIAMPolicy",
     "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
   ])
   policy_arn = each.value
}
