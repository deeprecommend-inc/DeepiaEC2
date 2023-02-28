# DeepConnectIfrastructure

## Command

- permission

```sh
$ chmod 400 cmcn_ec2
```

- ssh

```sh
$ ssh -i cmcn_ec2 ec2-user@52.196.143.137
```

- EC2 volume

```sh
$ df -hT /dev/xvda1
```

## Deploy

- Git close

```
$ git clone git@github.com:deep-recommend-sugimoto/CmCnApi.git
```

- Install packages

```sh
$ npm i --force --ignore-engines
```

- Give permission to sh file

```sh
$ chmod +x init-letsencrypt.sh
```

- Run script

```sh
$ sudo ./init-letsencrypt.sh
```

- Up docker container

```sh
$ docker-compose -f docker-compose.prod.yml up --build -d
```

## API URL (SSH)

git@github.com:deep-recommend-sugimoto/CmCnApi.git

## Update Elastic IP

- Mon Mar 21 15:46:12 JST 2022
  52.196.143.137
- Mon Mar 21 12:46:08 JST 2022
  35.73.73.152
- Mon Mar 21 11:31:04 JST 2022
  18.176.81.39
- Mon Mar 21 00:13:20 JST 2022
  35.78.33.32
- Sun Mar 20 12:02:51 JST 2022
  35.76.199.138
- Fri Mar 18 12:51:34 JST 2022
  54.249.110.102
- Fri Mar 18 12:37:16 JST 2022
  13.231.54.154
- Thu Mar 17 06:32:08 UTC 2022
  18.180.219.197
- Thu Mar 17 06:15:23 UTC 2022
  52.194.137.89
- Thu Mar 17 13:03:45 JST 2022
  18.180.219.197
- 3/17/2022
  18.182.223.43

## Reference

- Terraform
  https://blog.dcs.co.jp/aws/20210401-terraformaws.html#environment
  https://qiita.com/koki_develop/items/45cdde3d27bd75f1bfd5

## Environment Setting

- Preparing EC2 Environment
  - Docker install
    https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
  - Docker compose install
    https://docs.docker.com/compose/install/
  - https://qiita.com/miriwo/items/8d5b35950232c1126d36

## Installation

- Packaged

```
$ sudo yum -y install git make gcc-c++ patch openssl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt libxml2-devel libxslt-devel zlib-devel readline-devel mysql mysql-server mysql-devel ImageMagick ImageMagick-devel epel-release sqlite sqlite-devel
```

- Docker

```sh
$ sudo yum update -y
$ sudo amazon-linux-extras install docker
$ sudo yum install docker
$ sudo service docker start
$ sudo systemctl enable docker
$ sudo usermod -a -G docker ec2-user
$ docker info
```

- Docker Compose

```sh
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
$ docker-compose --version
```

- Git

```sh
$ sudo yum install git
```

- Node.js

```sh
$ curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash
$ sudo yum install -y nodejs
```
# DeepiaEC2
