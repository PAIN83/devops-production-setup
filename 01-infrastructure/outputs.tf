output "instance_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "Open this in your browser"
  value       = "http://${aws_instance.web.public_ip}"
}

output "vpc_id" {
  description = "VPC that was created"
  value       = aws_vpc.main.id
}
