locals {
    route_tables = {
        "StorySphere-Public-RT" = [
        "0.0.0.0/0",
        module.vpc.internet_gateway_id
        ],
        "StorySphere-Private-RT" = [
        "0.0.0.0/0",
        module.vpc.nat_gateway_id
        ]
    }
}

module "vpc" {
    source = "./Modules/VPC"

    subnets      = var.subnets
    route_tables = local.route_tables
}