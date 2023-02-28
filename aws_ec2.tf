#----------------------------------------
# AMI
#----------------------------------------
data "aws_ami" "AMI_for_cmcn" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
#----------------------------------------
# EC2 instance
#----------------------------------------
resource "aws_instance" "Instance_for_cmcn" {
  ami                    = data.aws_ami.AMI_for_cmcn.image_id
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.Subnet_for_cmcn.id
  key_name               = aws_key_pair.cmcn_ec2.id
  vpc_security_group_ids = [aws_security_group.SecurityGroup_for_cmcn.id]

  tags = {
    Name = "cmcn-instance"
  }
}

#----------------------------------------
# ElasticIpP
#----------------------------------------
resource "aws_eip" "Eip_for_cmcn" {
  instance = aws_instance.Instance_for_cmcn.id
  vpc      = true

  tags = {
    Name = "ElasticIP_for_cmcn"
  }
}

#----------------------------------------
# Keypair
#----------------------------------------
resource "aws_key_pair" "cmcn_ec2" {
  key_name   = "cmcn_ec2"
  public_key = file("./cmcn_ec2.pub")
}