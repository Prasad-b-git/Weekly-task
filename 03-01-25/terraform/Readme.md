# Modularized AWS Infrastructure with Terraform

This project involves designing and deploying a modularized infrastructure on AWS using Terraform. The setup includes networking, security groups, EC2 instances, and an Application Load Balancer. Terraform's state is managed using an S3 bucket for scalability and maintainability.

---

## Features
- Modular design for reusability and scalability.
- Creation of a highly available VPC with public and private subnets.
- Security group configuration to allow controlled access.
- Deployment of EC2 instances in public and private subnets.
- Integration with an Application Load Balancer for traffic distribution.
- State management with S3 for version control.

---

## Tools and Technologies
- **Terraform** for Infrastructure as Code (IaC).
- **AWS CLI** for initial configuration.
- **Amazon Web Services (AWS)**: VPC, EC2, Security Groups, Application Load Balancer, and S3.

---

## Prerequisites
1. AWS account with appropriate permissions.
2. Installed versions of:
   - **AWS CLI** (v2 or later)
   - **Terraform** (v1.0 or later)
3. An SSH key pair created in the AWS console (e.g., `ngnix-key`).

---

## Installation and Setup

### Step 1: Install AWS CLI
Follow the official documentation to install the AWS CLI:
[Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

### Step 2: Configure AWS CLI
Run the following command to configure your AWS CLI with your credentials:
```bash
aws configure

## Installation and Setup

### Step 1: Install AWS CLI
Follow the official documentation to install the AWS CLI:
[Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

### Step 2: Configure AWS CLI
Run the following command to configure your AWS CLI with your credentials:
```bash
aws configure
```
Provide the following details:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Default output format (e.g., `json`)

### Step 3: Install Terraform
Download and install Terraform from the official website:
[Terraform Downloads](https://www.terraform.io/downloads)

Verify the installation:
```bash
terraform -version
```

---

## Project Structure

```
modules/
  ├── networking/
  ├── security/
  ├── compute/
  ├── loadbalancer/
main.tf
```

### Key Modules
1. **Networking**: Creates VPC, subnets, route tables, and an internet gateway.
2. **Security**: Configures security groups for public and private instances.
3. **Compute**: Deploys EC2 instances.
4. **Load Balancer**: Configures an Application Load Balancer.

---

## Usage

### Step 1: Initialize Terraform
Run the following command in the project root to initialize Terraform and download necessary providers:
```bash
terraform init
```

### Step 2: Plan the Deployment
Preview the changes Terraform will make:
```bash
terraform plan
```

### Step 3: Apply the Configuration
Deploy the infrastructure:
```bash
terraform apply
```

### Step 4: Destroy the Infrastructure
To tear down the infrastructure, run:
```bash
terraform destroy
```

---

## Remote State Management with S3
The Terraform state is stored in an S3 bucket for better versioning and collaboration. Ensure the S3 bucket and DynamoDB table for state locking are configured before deployment.

Example `backend` configuration in `main.tf`:
```hcl
terraform {
  backend "s3" {
    bucket         = "your-tfstate-bucket"
    key            = "path/to/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

---

## Outputs
After successful deployment, Terraform will output:
- VPC ID
- Public and private subnet IDs
- Security group IDs
- Instance IDs
- Application Load Balancer DNS
---
## AWS Architecture

Below is a high-level diagram of the AWS architecture deployed using this project:

![AWS Architecture](https://via.placeholder.com/1024x768.png?text=AWS+Architecture+Diagram)
---

## Best Practices
- Use version control (e.g., Git) for tracking changes.
- Always review `terraform plan` before applying changes.
- Regularly back up the S3 bucket for state files.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## Author
**Prasad Bandagale**
```

Feel free to customize the file further based on your specific project details!
