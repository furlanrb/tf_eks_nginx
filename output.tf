output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority 
}

output "lb_ip" {
  value = kubernetes_service.nginx.status.0.load_balancer.0.ingress.0.hostname
}
