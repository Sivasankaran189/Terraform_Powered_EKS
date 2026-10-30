variable "aws_region" {
  description = "AWS region used by the Floci emulator"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the TerraForge VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "kubernetes_version" {
  description = "Kubernetes version requested for the Floci EKS cluster"
  type        = string
  default     = "1.29"
}
