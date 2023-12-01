//Create s3 bucket
resource "aws_s3_bucket" "s3-dev" {
  bucket = "my-artifact-upload"
  region = var.aws_region

  tags = {
    Name        = "DevOps_bucket"
    Environment = "Dev"
  }
}