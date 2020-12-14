resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group_membership" "admin" {
  name = aws_iam_group.admin.name

  users = [
    aws_iam_user.juyoung_ssg_com.name,
  ]

  group = aws_iam_group.admin.name
}

resource "aws_iam_group_policy" "admin" {
  name = "admin-policy"
  group = aws_iam_group.admin.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
