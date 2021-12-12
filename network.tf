resource "aws_vpc" "eks-vpc" {
    cidr_block = "10.0.0.0/16"   
    tags = var.tags
}

resource "aws_subnet" "subnet-pub" {
  count = 2
  vpc_id     = "${aws_vpc.eks-vpc.id}"
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true"
  tags = var.tags
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = "${aws_vpc.eks-vpc.id}"
    tags = var.tags
}

resource "aws_route_table" "route_table" {
    vpc_id = "${aws_vpc.eks-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet_gateway.id}" 
    }
    tags = var.tags
}

resource "aws_route_table_association" "rt_assoc_sub"{
    count = 2
    subnet_id = aws_subnet.subnet-pub.*.id[count.index]
    route_table_id = "${aws_route_table.route_table.id}"
}


resource "aws_security_group" "eks-cluster" {
    name = "eks-secgroup-${var.project}_${terraform.workspace}"
    vpc_id = "${aws_vpc.eks-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = var.tags
}