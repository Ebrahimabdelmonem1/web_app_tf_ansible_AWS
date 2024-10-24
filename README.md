## Web App Deployment on AWS using Terraform and Ansible ##
 This project automates the deployment of a web application on AWS using Terraform for
 infrastructure provisioning 
and Ansible for configuration management. It demonstrates how to set up a robust, scalable, and
 high-availability 
environment using AWS services.
 Features- Infrastructure as Code (IaC): Infrastructure is provisioned using Terraform, including VPCs,
 Subnets, 
  Load Balancers, and EC2 instances.- Configuration Management: Ansible is used to configure the EC2 instances and deploy a Docker
 container running 
  an NGINX server.- High Availability: The application is deployed across multiple Availability Zones (AZs) to ensure
 redundancy.- Secure Access: A Bastion Host is used for secure access to private instances.- Scalable: Infrastructure can be easily scaled based on demand.

Project Structure

├── ansible/
│   ├── roles/
│   ├── playbooks/
│   ├── inventory/
│   └── ...
├── terraform/
│   ├── modules/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── README.md



- terraform/: Contains Terraform files for defining the AWS infrastructure.- ansible/: Contains Ansible playbooks and roles for configuration management.

Requirements
 
 1. AWS Account: Ensure you have access to AWS and appropriate IAM permissions.
 2. Terraform: Installed on your local machine.
 3. Ansible: Installed on your local machine.
 4. SSH Key Pair: For accessing EC2 instances via the Bastion Host.
 Setup and Deployment
 Step 1: Terraform - Infrastructure Provisioning
 1. Clone the repository:
    git clone https://github.com/Ebrahimabdelmonem1/web_app_tf_ansible_AWS.git
 #   cd web_app_tf_ansible_AWS/terraform
 2. Initialize Terraform:
 #   terraform init
3. Plan the infrastructure:
 #   terraform plan
 4. Apply the changes to create the infrastructure:
 #   terraform apply
 5. Once applied, Terraform will output the public IP of the Bastion Host and Load Balancer.
 Step 2: Ansible - Configuration Management
 1. Navigate to the ansible/ directory:
#    cd ../ansible
 2. Update the inventory file with the Bastion Host and private EC2 instance details.
 3. Run the Ansible playbook to configure the instances and deploy the Docker container:
 #   ansible-playbook -i inventory playbook.yml
 4. Access the web app using the Load Balancer's public DNS.
 Components Deployed- VPC: Virtual Private Cloud with both public and private subnets.- EC2 Instances: Deployed in private subnets to host the web application.- Load Balancer: Balances traffic between instances across multiple AZs.- Bastion Host: Allows secure access to EC2 instances in the private subnets.
 Clean-Up
To destroy the infrastructure and avoid unwanted AWS charges, run the following command from
 the terraform/ directory:
#    terraform destroy
 
 License
 This project is licensed under the MIT License - see the LICENSE file for details
