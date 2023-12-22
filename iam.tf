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