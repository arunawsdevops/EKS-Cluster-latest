#  Node Scheduling with Node Selectors & Node Affinity #

In Kubernetes, you can control **where pods get scheduled** by using:

- `nodeSelector`: A simple way to assign pods to nodes with specific labels.
- `nodeAffinity`: A more flexible and powerful method that supports expressions and priorities.

---


## Types of Node Affinity ##

Type &	Description
1.requiredDuringSchedulingIgnoredDuringExecution	 — pod won't schedule unless condition is met
2.preferredDuringSchedulingIgnoredDuringExecution	 — kubernetes will try to honor it, but won’t block the pod from being scheduled elsewhere if no matching nodes are available.

## label nodes ##
1. Labeling Nodes
Before you can schedule pods to specific nodes, you need to label your nodes.

### Syntax: kubectl label nodes <node-name> <key>=<value> ###
kubectl label nodes ip-192-168-1-1.ec2.internal size=large

## remove the label ##
## kubectl label nodes <node-name> <label-key>- ##
kubectl label nodes ip-192-168-1-1.ec2.internal size=large-



## taints and tolerations ##

##  Taints and Tolerations in Kubernetes

Taints and tolerations are used to **control which pods can run on which nodes**.

---

###  Taints

A **taint** is applied to a **node**, and it repels all pods **unless** those pods have a matching **toleration**.

This allows you to dedicate certain nodes for specific workloads or isolate sensitive resources like GPUs or storage.

---

### Tolerations

A **toleration** is applied to a **pod**, and it allows that pod to be scheduled onto nodes with matching taints.

---

###  How It Works

1. **Taint a node** to say:  
   _"Only pods that tolerate this taint may run here."_

2. **Add a toleration to a pod** to say:  
   _"I tolerate this taint — I can be scheduled on that node."_

---

##  Taint Effects Explained

| Effect              | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| `NoSchedule`        | Pods will **not** be scheduled unless they have a matching toleration       |
| `PreferNoSchedule`  | Scheduler **tries to avoid** placing pods on the node                       |
| `NoExecute`         | Not only blocks scheduling, but **evicts existing pods** without toleration |

---






## Syntax: kubectl taint nodes <node-name> <key>=<value>:<effect> ##

## Example: Taint node so that only certain pods can run on it ##
kubectl taint nodes <node-name> app=equal:NoSchedule

## remove the taint ##
## Syntax: kubectl taint nodes <node-name> <key>:<effect>- ## 
kubectl taint nodes <node-name> app=equal:NoSchedule





## install EFS CSI(Container Storage Interface) in eks cluster for efs pv and pvc ##
### Clone the AWS EFS CSI driver repository ###
git clone https://github.com/kubernetes-sigs/aws-efs-csi-driver.git

### Navigate to the deployment directory ###
cd aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr

### Apply the Kubernetes manifests using Kustomize ###
kubectl apply -k .

### Alternatively, apply the specific kustomization file ###
kubectl apply -f kustomization.yaml

### Check if the EFS CSI pods are running ###
kubectl get pods -n kube-system
  you can see efs-controller pod, and other pod

  ## Set Up EFS for Your EKS Cluster ##
### Create an EFS file system in your AWS account: ###

1. Go to the Amazon EFS Console.

2. Create a new file system in the same VPC and region as your EKS nodes.
3. Note the File System ID (e.g., fs-12345678).
4. Update your efs-pv.yaml file with the EFS File System ID:



