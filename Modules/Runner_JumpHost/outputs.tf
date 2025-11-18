output "latest_ubuntu_ami" {
    value= data.aws_ami.ubuntu.id
}

output "Workflow_runner_id" {
    value = aws_instance.runner.id
}