# Terraform Project: Manage AWS EC2 Instance

This Terraform project is designed to manage an AWS EC2 instance named "test-ec2" and ensure that the following attributes are Terraform-managed:

- Instance profile
- Userdata
- Security group

Additionally, the project configures Terraform to save its state in an existing S3 bucket (`tf-state-159729213779`) and utilizes DynamoDB for state locking.

## Getting Started

These instructions will help you deploy and manage the EC2 instance using Terraform.

### Prerequisites

Before you begin, make sure you have:

- An AWS account
- Terraform installed on your local machine
- AWS CLI configured with appropriate credentials and permissions

### Configuration

1. Clone the repository to your local machine.

2. Update the `backend` configuration in `main.tf` with your S3 bucket details:

   ```hcl
   terraform {
     backend "s3" {
       bucket  = "tf-state-159729213779"
       key     = "terraform.tfstate"
       region  = "eu-west-1"
       encrypt = true
     }
   }
   ```

3. Ensure that the VPC, subnet, and security group IDs are correctly specified in `main.tf`.

4. Customize the EC2 instance configuration in `main.tf` as needed (AMI, instance type, key name, etc.).

5. Run `terraform init` to initialize the Terraform configuration.

6. Run `terraform plan` to review the execution plan.

7. Run `terraform apply` to apply the changes and provision the EC2 instance.

## Usage

Once the EC2 instance is provisioned, you can manage it using Terraform commands:

- `terraform plan`: Generate an execution plan.
- `terraform apply`: Apply the changes and provision/update the EC2 instance.
- `terraform destroy`: Destroy the EC2 instance.

## Built With

- [Terraform](https://www.terraform.io/) - Infrastructure as Code tool by HashiCorp

## Authors

- Ade Johnson

## License

This project is licensed under the [MIT License] - see the [LICENSE.md](LICENSE.md) file for details.
