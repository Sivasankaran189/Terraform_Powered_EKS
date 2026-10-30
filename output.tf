output "vpc_id" {
  description = "ID of the TerraForge VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the TerraForge VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the TerraForge internet gateway"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "worker_security_group_id" {
  description = "ID of the TerraForge worker management security group"
  value       = aws_security_group.all_worker_mgmt.id
}

output "eks_cluster_name" {
  description = "Name of the TerraForge EKS-compatible cluster"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "API endpoint returned for the TerraForge cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_status" {
  description = "Status reported for the TerraForge cluster"
  value       = aws_eks_cluster.main.status
}
