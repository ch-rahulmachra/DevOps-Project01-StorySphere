resource "aws_internet_gateway" "ss_igw" {
    vpc_id = aws_vpc.ss_vpc.id

    tags = {
        Name = "StorySphere-IGW"
    }
}

resource "aws_eip" "ss_eip" {
    domain = "vpc"

    tags = {
        Name = "StorySphere-EIP"
    }
}

resource "aws_nat_gateway" "ss_nat" {
    allocation_id = aws_eip.ss_eip.id
    subnet_id     = aws_subnet.ss_subnet["StorySphere-Public-Subnet"].id

    tags = {
        Name = "StorySphere-NAT-GW"
    }

    depends_on = [aws_internet_gateway.ss_igw]
}