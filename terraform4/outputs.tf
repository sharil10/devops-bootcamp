output "rackula_url" {
  description = "Working Rackula URL (served on port 8080)"
  value       = "http://${module.rackula_server.public_ip}:8080"
}

output "rackula_server_id" {
  description = "EC2 instance ID"
  value       = module.rackula_server.id
}

output "ssm_command" {
  description = "SSM Session Manager command to connect to the instance"
  value       = "aws ssm start-session --target ${module.rackula_server.id}"
}