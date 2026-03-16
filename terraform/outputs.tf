output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "bucket_arn" {
  description = "ARN do bucket S3 criado"
  value       = aws_s3_bucket.app_bucket.arn
}

output "bucket_region" {
  description = "Região onde o bucket foi criado"
  value       = var.aws_region
}
