output "public_ip" {
  value = aws_eip.Eip_for_deepia.public_ip
}
