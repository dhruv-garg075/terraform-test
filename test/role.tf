data "aws_iam_policy" "test_policy" {
  arn = "arn:aws:iam::430288206927:policy/ALBIngressControllerIAMPolicy"
}

resource "aws_iam_role" "test_service_role" {
  name = "TestServiceRole"
  assume_role_policy = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "test_policy_attach" {
   role       = "${aws_iam_role.test_service_role.name}"
   policy_arn = "${data.aws_iam_policy.test_policy.arn}"
}
