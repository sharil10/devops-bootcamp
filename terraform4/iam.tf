data "aws_iam_policy" "ssm_managed_core" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "rackula_ssm_role" {
  name = "rackula-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = { Name = "rackula-ssm-role" }
}

resource "aws_iam_role_policy_attachment" "rackula_ssm_attach" {
  role       = aws_iam_role.rackula_ssm_role.name
  policy_arn = data.aws_iam_policy.ssm_managed_core.arn
}

resource "aws_iam_instance_profile" "rackula_ssm_profile" {
  name = "rackula-ssm-profile"
  role = aws_iam_role.rackula_ssm_role.name
}
