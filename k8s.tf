data "aws_eks_cluster" "mycluster" {
  name = "cluster_${var.project}_${terraform.workspace}"
  depends_on = [
      aws_eks_cluster.eks_cluster
    ]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.mycluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.mycluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.mycluster.name
    ]
  }
  
}
