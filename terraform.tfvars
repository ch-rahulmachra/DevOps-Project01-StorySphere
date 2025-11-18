subnets = {
    "StorySphere-Public-Subnet" = [ "10.0.0.0/25", "ap-south-1a" ],
    "StorySphere-Private-Subnet" = [ "10.0.0.128/25", "ap-south-1b" ]
}

# route_tables = {
#     "StorySphere-Public-RT" = [ "10.0.0.0/25", "${module.vpc.internet_gateway_id}" ],
#     "StorySphere-Private-RT" = [ "10.0.0.128/25", "${module.vpc.nat_gateway_id}" ]
# }

vpc_cidr = "10.0.0.0/24"