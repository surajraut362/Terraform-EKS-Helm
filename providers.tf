

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.test-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.test-cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.test-cluster.token

    # exec {
    #   api_version = "client.authentication.k8s.io/v1"
    #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.test-cluster.name]
    #   command     = "aws"
    # }
  
  }
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.test-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.test-cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.test-cluster.token
  #load_config_file       = false
}

provider "aws" {
  region = var.aws_region
}
