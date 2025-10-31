resource "aws_vpc" "ss-vpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "StorySphere-VPC"
    }
}

resource "aws_subnet" "ss-subnet" {
    vpc_id     = aws_vpc.ss-vpc.id

    for_each = var.subnets

    cidr_block = each.value[0]

    availability_zone = each.value[1]

    tags = {
        Name = each.key
    }
}

resource "aws_internet_gateway" "ss-igw" {
    vpc_id = aws_vpc.ss-vpc.id

    tags = {
        Name = "StorySphere-IGW"
    }
}



resource "aws_route_table" "ss-route-table" {
    vpc_id = aws_vpc.ss-vpc.id

    for_each = var.route_tables

    route {
        cidr_block = "10.0.0.0/24"
        gateway_id = "local"
    }

    route = {
        cidr_block = each.value[0]
        gateway_id = each.value[1]
    }

    tags = {
        Name = each.key
    }
}