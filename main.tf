# IAM Role for the EKS Cluster
resource "aws_iam_role" "cluster-role" {
  name = "cluster-role-2"

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
}

# Attach necessary policies to the cluster role
resource "aws_iam_role_policy_attachment" "cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster-role.name
}

# IAM Role for the EKS Node Group
resource "aws_iam_role" "node-role" {
  name = "node-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach necessary policies to the node role
resource "aws_iam_role_policy_attachment" "node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-role.name
}

resource "aws_iam_role_policy_attachment" "cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"  # Updated policy ARN
  role       = aws_iam_role.node-role.name
}

resource "aws_iam_role_policy_attachment" "registry-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-role.name
}

# EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "k8-cluster-latest"
  role_arn = aws_iam_role.cluster-role.arn
  version  = "1.33"

  vpc_config {
    subnet_ids         = ["subnet-00a2921ddce84b773", "subnet-0884091f590eb3f84"]
    security_group_ids = ["sg-0bb25d7ef1c8b14d8"]
  }

  depends_on = [aws_iam_role_policy_attachment.cluster-policy]
}

# EKS Node Group
resource "aws_eks_node_group" "k8-cluster-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "k8-cluster-node-group-latest"
  node_role_arn   = aws_iam_role.node-role.arn
  subnet_ids      = ["subnet-00a2921ddce84b773", "subnet-0884091f590eb3f84"]


  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 5
  }

  depends_on = [aws_iam_role_policy_attachment.node-policy]
}