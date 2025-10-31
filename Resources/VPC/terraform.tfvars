subnets = {
    "StorySphere-Public-Subnet" = [ "10.0.0.0/25", "ap-south-1a" ],
    "StorySphere-Private-Subnet" = [ "10.0.0.128/25", "ap-south-1b" ]
}

route_tables = {
    "StorySphere-Public-RT" = [ "10.0.0.0/25", "${aws_internet_gateway.ss-igw.id}" ],
    "StorySphere-Private-RT" = [ "10.0.0.128/25", "" ]
}