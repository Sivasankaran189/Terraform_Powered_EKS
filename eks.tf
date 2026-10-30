resource "aws_iam_role" "eks_cluster" {
  name = "terraforge-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = "TerraForge"
  }
}

resource "aws_eks_cluster" "main" {
  name     = "terraform-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = aws_subnet.private[*].id
  }

  tags = {
    Project = "TerraForge"
  }
}
