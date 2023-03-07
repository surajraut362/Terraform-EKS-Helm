# ------------------------------------------------------------
# Networking Settings
# ------------------------------------------------------------
aws_region              = "us-west-2"
vpc_cidr_block          = "10.0.0.0/16"
test1_subnet_az         = "us-west-2a"
test1_subnet_cidr_block = "10.0.1.0/24"
test2_subnet_az         = "us-west-2b"
test2_subnet_cidr_block = "10.0.2.0/24"
# ------------------------------------------------------------
# EKS Cluster Settings
# ------------------------------------------------------------
cluster_name                       = "test-cluster"
cluster_version                    = "1.24"
worker_group_name                  = "test-worker-group-1"
worker_group_instance_type         = ["t3.medium"]
autoscaling_group_min_size         = 1
autoscaling_group_max_size         = 3
autoscaling_group_desired_capacity = 2

