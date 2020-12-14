resource "aws_s3_bucket" "s3" {
  bucket = "ssg-terraform-101-juyoung"
#  acl    = "public-read"


  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::ssg-terraform-101-juyoung/*"]
    }
  ]
}
EOF

}

resource "aws_s3_bucket" "s3_2" {
  bucket = "ssg-this-is-masocampus"

}
