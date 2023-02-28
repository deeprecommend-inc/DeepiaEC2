output "public_ip" {
  value = aws_eip.Eip_for_cmcn.public_ip
}
