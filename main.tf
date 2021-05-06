resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
   tags = {
    Name = "vpc-tf"
  }
}

resource "aws_subnet" "pub01" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.snet_pub01_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "snet-tf-pub-01"
  }
   }

   resource "aws_subnet" "pub02" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.snet_pub02_cidr_block
  availability_zone = "us-east-1b"
  tags = {
    Name = "snet-tf-pub-02"
  }
   }

   resource "aws_subnet" "priv01" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.snet_priv01_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "snet-tf-priv-01"
  }
   }
   resource "aws_subnet" "priv02" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.snet_priv02_cidr_block
  availability_zone = "us-east-1b"
  tags = {
    Name = "snet-tf-priv-02"
  }
   }

   resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-tf"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    Name = "rt-tf-public"
  }
}

resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.pub01.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.pub02.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "main" {
  name        = "sec-tf-name"
  description = "Main security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH Port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.main.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS Port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.main.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sec-tf-name"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t3.micro"
  key_name = var.keyName
  subnet_id = aws_subnet.pub01.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "vm-tf-01"
  }
}



