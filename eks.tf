resource "aws_eks_cluster" "eks_cluster" {
  name     = "cluster_${var.project}_${terraform.workspace}"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster.id]
    subnet_ids         = aws_subnet.subnet-pub[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster-AmazonEKSServicePolicy,
  ]
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = aws_subnet.subnet-pub[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_node-AmazonEC2ContainerRegistryReadOnly,
  ]
}