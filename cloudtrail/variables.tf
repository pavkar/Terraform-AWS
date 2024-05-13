variable "cloudtrail_name" {
  type        = string
  description = "The name of the CloudTrail"
  default     = "cloudtrail-test"
}

variable "cloudtrail_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for CloudTrail logs"
  default     = "cloudtrail-test-bucket"
}