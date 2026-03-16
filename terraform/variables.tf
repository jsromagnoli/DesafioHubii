variable "aws_region" {
  description = "Região da AWS onde o bucket será criado"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome único do bucket S3"
  type        = string
  default     = "desafio-hubii-bucket"
}

variable "environment" {
  description = "Ambiente de deployment"
  type        = string
  default     = "production"
}
