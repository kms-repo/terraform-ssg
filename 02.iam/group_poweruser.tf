resource "aws_iam_group" "poweruser" {
  name = "poweruser"
}

resource "aws_iam_group_membership" "poweruser" {
  name = aws_iam_group.poweruser.name

  users = [
    aws_iam_user.masocampus_ssg_com.name
  ]

  group = aws_iam_group.poweruser.name
}

resource "aws_iam_group_policy" "poweruser" {
  name = "poweruser-policy"
  group = aws_iam_group.poweruser.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*",
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
