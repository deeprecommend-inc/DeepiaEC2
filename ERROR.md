# EC2 立ち上がらない

## 1. ssh で EC2 に入って、docker-compose up したらフリーズ

- 原因<br>
  => 容量不足
  => もしかすると.dockerignore か.gitignore から Dockerfile を取り除いたことが原因

- 対処法<br>
  => EC2 を ts.micro から ts.small に変更

<hr>

## 2. kex_exchange_identification: read: Connection reset by peer というメッセージで ssh 接続できなくなる

- 原因<br>
  => Terraform のインスタンスの設定で user_data を含めてしまったことでアパッチが起動した

- 対処法<br>
  => user_data をまるごと削除してから terraform apply する

- 該当のソースコード

```hcl
resource "aws_instance" "Instance_for_cmcn" {
  ami                    = data.aws_ami.AMI_for_cmcn.image_id
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.Subnet_for_cmcn.id
  key_name               = aws_key_pair.cmcn_ec2.id
  vpc_security_group_ids = [aws_security_group.SecurityGroup_for_cmcn.id]

  user_data = <<EOF
  #! /bin/bash
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo yum install -y ssld
  sudo systemctl start ssld
  sudo systemctl enable ssld
  EOF

  tags = {
    Name = "cmcn-instance"
  }
}
```