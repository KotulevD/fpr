output "public_ip" {
  value       = aws_eip.prodapp.public_ip
  description = "The public IP address of devapp server"
}

