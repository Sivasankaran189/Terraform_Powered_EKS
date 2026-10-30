resource "aws_security_group" "all_worker_mgmt" {
  name        = "terraforge-worker-management"
  description = "Security group for TerraForge Kubernetes worker management"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH from the configured management network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Allow communication within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "terraforge-worker-management"
    Project = "TerraForge"
  }
}
