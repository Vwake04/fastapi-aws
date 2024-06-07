resource "aws_kms_key" "state-terraform" {
  description             = "KMS Key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "state-key-alias" {
  name          = "alias/state-terraform"
  target_key_id = aws_kms_key.state-terraform.key_id
}


resource "aws_s3_bucket" "state-terraform" {
  bucket = "state-terraform-bucket-blue"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.state-terraform.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state-terraform" {
  bucket = aws_s3_bucket.state-terraform.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "state-terraform" {
  name           = "state-terraform"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}