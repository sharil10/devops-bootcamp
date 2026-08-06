module "rackula_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "rackula-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  # Rackula serves on port 8080 (RACKULA_PORT/RACKULA_LISTEN_PORT default)
  ingress_rules = {
    rackula_http = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 8080
      to_port     = 8080
      description = "Rackula web UI"
    }
  }

  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1", description = "Allow all outbound" }
  }

  tags = { Name = "rackula-sg" }
}