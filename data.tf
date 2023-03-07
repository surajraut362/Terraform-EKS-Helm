data "aws_eks_cluster" "test-cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "test-cluster" {
  name = module.my-cluster.cluster_id
}