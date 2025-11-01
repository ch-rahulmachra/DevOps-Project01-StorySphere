output "vpc_id" {
    description = "ID of the VPC"
    value       = aws_vpc.ss_vpc.id
}

output "public_subnet_ids" {
    description = "IDs of all public subnets"
    value       = [for k, s in aws_subnet.ss_subnet : s.id if strcontains(k, "StorySphere-Public-Subnet")]
}

output "private_subnet_ids" {
    description = "IDs of all private subnets"
    value       = [for k, s in aws_subnet.ss_subnet : s.id if strcontains(k, "StorySphere-Private-Subnet")]
}

output "internet_gateway_id" {
    description = "ID of the Internet Gateway"
    value       = aws_internet_gateway.ss_igw.id
}

output "nat_gateway_id" {
    description = "ID of the NAT Gateway"
    value       = aws_nat_gateway.ss_nat.id
}

output "route_table_ids" {
    description = "IDs of all route tables"
    value       = { for k, rt in aws_route_table.ss_route_table : k => rt.id }
}