resource "aws_vpc" "ss_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "StorySphere-VPC"
    }
}

resource "aws_subnet" "ss_subnet" {
    vpc_id     = aws_vpc.ss_vpc.id

    for_each = var.subnets

    cidr_block = each.value[0]

    availability_zone = each.value[1]

    tags = {
        Name = each.key
    }
}

resource "aws_route_table" "ss_route_table" {
    vpc_id = aws_vpc.ss_vpc.id

    for_each = var.route_tables

    route {
        cidr_block = each.value[0]
        gateway_id = each.value[1]
    }

    tags = {
        Name = each.key
    }
}

resource "aws_route_table_association" "ss_table_association" {
    for_each = {
        "StorySphere-Public-Subnet"  = aws_route_table.ss_route_table["StorySphere-Public-RT"].id
        "StorySphere-Private-Subnet" = aws_route_table.ss_route_table["StorySphere-Private-RT"].id
    }

    subnet_id      = aws_subnet.ss_subnet[each.key].id
    route_table_id = each.value
}