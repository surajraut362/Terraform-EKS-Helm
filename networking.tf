resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "testelopment"
  }
}

# Subnets have to be allowed to automatically map public IP addresses for worker nodes
resource "aws_subnet" "test1-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = var.test1_subnet_cidr_block
  availability_zone       = var.test1_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "test1-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "test2-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = var.test2_subnet_cidr_block
  availability_zone       = var.test2_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "test2-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "test-gw"
  }
}

resource "aws_route_table" "test-route-table" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.test-gw.id
  }


  tags = {
    Name = "test-rt"
  }
}

resource "aws_route_table_association" "test1-sub-to-test-rt" {
  subnet_id      = aws_subnet.test1-subnet.id
  route_table_id = aws_route_table.test-route-table.id
}

resource "aws_route_table_association" "test2-sub-to-test-rt" {
  subnet_id      = aws_subnet.test2-subnet.id
  route_table_id = aws_route_table.test-route-table.id
}

resource "aws_security_group" "allow-web-traffic" {
  name        = "allow_tls"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-web"
  }
}
