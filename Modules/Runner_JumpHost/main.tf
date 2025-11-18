data "aws_ami" "ubuntu" {
    most_recent = true

    owners = ["099720109477"]

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "name"
        values = ["ubuntu/images/*ubuntu-24.04-amd64-server-*"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
}

resource "aws_security_group" "ss_runner_sg" {
    name        = "StorySphere-Workflow-Runner-SG"
    vpc_id      = var.vpc_id

    tags = {
        Name = "StorySphere-Workflow-Runner-SG"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_vpc_ssh" {
    security_group_id = aws_security_group.ss_runner_sg.id
    referenced_security_group_id = aws_security_group.ss_bastion_sg.id
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_runner_traffic" {
    security_group_id = aws_security_group.ss_runner_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1"
}

resource "aws_instance" "runner" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    tags = {
        Name = "StorySphere-Workflow-Runner"
        Environment = "${ terraform.workspace }"
    }
    key_name = "demo-key"
    subnet_id = var.subnet_id
    associate_public_ip_address = false
    vpc_security_group_ids = [
        aws_security_group.ss_runner_sg.id
    ]

    root_block_device {
        volume_size = var.volume_size
        volume_type = "gp3"
        delete_on_termination = true
        device_name = "/dev/sda1"
        iops = 3000
    }
}


resource "aws_security_group" "ss_bastion_sg" {
    name        = "StorySphere-Bastion-SG"
    vpc_id      = var.vpc_id

    tags = {
        Name = "StorySphere-Bastion-SG"
    }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_local_ssh" {
    security_group_id = aws_security_group.ss_bastion_sg.id
    cidr_ipv4         = "103.248.87.186/32"
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_bastion_traffic" {
    security_group_id = aws_security_group.ss_bastion_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1"
}

resource "aws_instance" "jump_host" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    tags = {
        Name = "StorySphere-Jump-Host"
        Environment = "${ terraform.workspace }"
    }
    key_name = "demo-key"
    subnet_id = var.bastion_subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids = [
        aws_security_group.ss_bastion_sg.id
    ]

    root_block_device {
        volume_size = var.bastion_volume_size
        volume_type = "gp3"
        delete_on_termination = true
        device_name = "/dev/sda1"
        iops = 3000
    }
}