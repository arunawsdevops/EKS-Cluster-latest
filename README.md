# 1. Create EKS Cluster
   Once the EKS cluster is created,run the following command
   aws eks  --region <region> update-kubeconfig --name <cluster-name>
# 2. Configure Jenkins with Kubernetes Credentials
   Steps:
  ## Create and Configure Jenkins Credentials:
    In Jenkins, go to Manage Jenkins > Manage Credentials > Global Credentials
    Click on Add Credentials
    Select "Secret file"
    Browse and select your kubeconfig file (.kube/config)
# 3. Install kubectl on Jenkins master and node.
# 4. Create Jenkins Pipeline to Connect to EKS
