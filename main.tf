# Configure the AWS provider with the specified region
provider "aws" {
  region = "eu-west-1"
}

# Define an IAM role with the provided ARN
resource "aws_iam_role" "test_ec2_role" {
  name = "test-ec2"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonSSMFullAccess policy to the IAM role
resource "aws_iam_policy_attachment" "attach_ssm_full_access" {
  name       = "ssm_full_access"
  roles      = [aws_iam_role.test_ec2_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# Attach the AmazonSSMManagedInstanceCore policy to the IAM role
resource "aws_iam_policy_attachment" "attach_ssm_managed_instance_core" {
  name       = "ssm_managed_instance_core"
  roles      = [aws_iam_role.test_ec2_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Define an IAM instance profile and attach the IAM role to it
resource "aws_iam_instance_profile" "test_profile" {
  name = "IAM_Role_SSM"
  role = aws_iam_role.test_ec2_role.arn
}

# Placeholder for VPC, subnet, and security group IDs 
locals {
  vpc_id             = "vpc-0bfd35589fab225d1"
  subnet_id          = "subnet-0a379436ca27e001b"
  security_group_ids = ["sg-0b14def64fc22b5b8"]
}

# Create an AWS EC2 instance named "test-ec2" and assign the IAM instance profile
resource "aws_instance" "test-ec2" {
  ami                    = "ami-02cad064a29d4550c"
  instance_type          = "t2.micro"
  key_name               = "ec2-keypair"
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.test_profile.name

  # Define an attached volume for the instance
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_type = "gp3"
    iops        = 3000
    encrypted   = false
    snapshot_id = "snap-0536df1fed2e4b339"
  }

  # Define user data script for instance boot-up
  user_data = <<-EOF
    #!/bin/bash
    # Script to create timestamp for every EC2 reboot

    # File path
    FILE="/tmp/reboots.txt"

    # Check if the file exists. If not, create it.
    if [ ! -f "$FILE" ]; then
        touch "$FILE"
    fi

    # Append the current date and time to the file
    echo "Boot up at $(date)" >> "$FILE"
  EOF

  # Prevent Terraform from replacing the instance
  lifecycle {
    prevent_destroy = true
  }
}

# Configure Terraform backend to store state in an S3 bucket
terraform {
  backend "s3" {
    bucket  = "tf-state-159729213779"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
