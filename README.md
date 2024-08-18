# CKA Exam Study Notes

I've had this repository for 2 years now. I sat for the exam and failed. I gave up my pursuit to take the CKA certification, but now I'm back.

Here I'll share my study notes, the resources used, and the labs taken.

I plan to sit for the exam some time around the end of October.

## Resources

I'm using the following resources to prepare for the exam:

- [The Kubernetes Book](https://github.com/nigelpoulton/TheK8sBook) by [Nigel Poulton](https://nigelpoulton.com/)
- [Acing the Certified Kubernetes Administrator Exam](https://www.manning.com/books/acing-the-certified-kubernetes-administrator-exam)
- [Acing the CKA Exam GitHub repository](https://github.com/chadmcrowell/acing-the-cka-exam)
- [Killer Coda CKA scenarios](https://killercoda.com/cka)
- [KodeKloud CKA course](https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/)
- [KodeKloud GitHub repository](https://github.com/kodekloudhub/certified-kubernetes-administrator-course)
- [Certified Kubernetes Administrator - Real World](https://www.udemy.com/course/certified-kubernetes-administrator-cka-real-world/)

### Other resources

- [CKA exam page](https://training.linuxfoundation.org/certification/certified-kubernetes-administrator-cka/)
- [The CKA curriculum](https://github.com/cncf/curriculum/blob/master/CKA_Curriculum_v1.30.pdf)
- [Candidate Handbook](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2)
- [Exam tips](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)

## Contents

I'm dividing the contents in sections according to the current curriculum outline (version 1.3). In each section there are the labs I took from the different courses, and some study notes.

## Cluster Architecture, Installation and configuration

### Labs

- [Preparing the environment](Architecture_Installation_and_Configuration/Labs/environment.md)
- [Configuring the control plane](Architecture_Installation_and_Configuration/Labs/configure_cp.md)
- [Configuring the worker node](Architecture_Installation_and_Configuration/Labs/configure_worker.md)
- [Deploying a simple application](Architecture_Installation_and_Configuration/Labs/deploy_app.md)
- [Backing up the etcd database](Architecture_Installation_and_Configuration/Labs/backup_etcd.md)
- [Upgrading the cluster](Architecture_Installation_and_Configuration/Labs/upgrade_cluster.md)

### Notes

- [Introduction to Kubernetes](Architecture_Installation_and_Configuration/Notes/What_is_Kubernetes.md)
- [The Control plane](/Architecture_Installation_and_Configuration/Notes/The_control_plane.md)
- [The Worker node](/Architecture_Installation_and_Configuration/Notes/The_worker_node.md)
- [Deploying the underlying infrastructure in Azure](/Architecture_Installation_and_Configuration/Notes/Infrastructure.md)
- [Using Kubeadm to install a basic cluster](/Architecture_Installation_and_Configuration/Notes/Kubeadm.md)
- [YAML in Kubernetes](Architecture_Installation_and_Configuration/Notes/YAML_Kubernetes.md)
