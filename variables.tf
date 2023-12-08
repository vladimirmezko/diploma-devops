variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "mezko"
}

variable "image_id" {
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}