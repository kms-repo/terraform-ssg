resource "aws_iam_role" "admin" {
  name = "admin-iam-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "admin" {
  name = "admin-policy"
  role = aws_iam_role.admin.id

  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "Admin",
      "Action": [
        "*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "admin" {
  name = "admin-profile-ssg"
  role = aws_iam_role.admin.name
}


