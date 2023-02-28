#----------------------------------------
# AMI
#----------------------------------------
data "aws_ami" "AMI_for_deepia" {
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
resource "aws_instance" "Instance_for_deepia" {
  ami                    = data.aws_ami.AMI_for_deepia.image_id
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.Subnet_for_deepia.id
  key_name               = aws_key_pair.deepia_ec2.id
  vpc_security_group_ids = [aws_security_group.SecurityGroup_for_deepia.id]

  tags = {
    Name = "deepia-instance"
  }
}

#----------------------------------------
# ElasticIpP
#----------------------------------------
resource "aws_eip" "Eip_for_deepia" {
  instance = aws_instance.Instance_for_deepia.id
  vpc      = true

  tags = {
    Name = "ElasticIP_for_deepia"
  }
}

#----------------------------------------
# Keypair
#----------------------------------------
resource "aws_key_pair" "deepia_ec2" {
  key_name   = "deepia_ec2"
  public_key = file("./deepia_ec2.pub")
}