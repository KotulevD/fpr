#output "alb_dns_name" {
#  value       = aws_lb.example.dns_name
#  description = "The domain name of the load balancer"
#}

output "public_ip" {
  value       = aws_eip.devapp.public_ip
  description = "The public IP address of devapp server"
}

