resource "aws_eks_cluster" "testekscluster" {
  count                     = length(var.subnet)
  enabled_cluster_log_types = ["audit", "scheduler"]
  name                      = "test-eks-cluster"
  role_arn                  = aws_iam_role.Eks_Cluster_Role.arn #"arn:aws:iam::357028046444:role/AmazonEKSClusterPolicy"
  tags = {
    Name = "test-eks-cluster"
  }
  tags_all = {
    Name = "test-eks-cluster"
  }
  version = "1.28"
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.100.0.0/16"
  }
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = [data.aws_security_group.default_sg.id] #["sg-06330bcdf0e7a9062"]
    subnet_ids              = var.subnet                              #["subnet-0354bed558262baa5", "subnet-03b843b0bfd58d350", "subnet-0542fb0ef8e8d648e", "subnet-0ff5a4fa1ae7957d8"]
  }
  depends_on = [aws_iam_role.Eks_Cluster_Role, aws_iam_role.Amazon_EKS_NodeRole]
}
