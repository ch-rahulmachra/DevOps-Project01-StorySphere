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
    vpc_cidr = var.vpc_cidr
}

module "runner" {
    source = "./Modules/Runner_JumpHost"
    subnet_id = module.vpc.private_subnet_ids[0]
    volume_size = 20
    vpc_id = module.vpc.vpc_id
    vpc_cidr = var.vpc_cidr
    bastion_volume_size = 8
    bastion_subnet_id = module.vpc.public_subnet_ids[0]
}