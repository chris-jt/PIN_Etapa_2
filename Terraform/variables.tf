variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for Debian"
  default     = "ami-0fec2c2e2017f4e7b"  # Debian 11 (bullseye) en us-east-1
}

variable "key_name" {
  description = "Name of the EC2 key pair"
}