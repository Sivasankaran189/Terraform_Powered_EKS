resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "terraforge-vpc"
    Project = "TerraForge"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = [
    "10.0.4.0/24",
    "10.0.5.0/24"
  ][count.index]

  availability_zone = [
    "us-east-1a",
    "us-east-1b"
  ][count.index]

  map_public_ip_on_launch = true

  tags = {
    Name                                       = "terraforge-public-${count.index + 1}"
    Project                                    = "TerraForge"
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/cluster/terraforge-cluster" = "shared"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ][count.index]

  availability_zone = [
    "us-east-1a",
    "us-east-1b"
  ][count.index]

  tags = {
    Name                                       = "terraforge-private-${count.index + 1}"
    Project                                    = "TerraForge"
    "kubernetes.io/role/internal-elb"          = "1"
    "kubernetes.io/cluster/terraforge-cluster" = "shared"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "terraforge-igw"
    Project = "TerraForge"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name    = "terraforge-public-rt"
    Project = "TerraForge"
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
