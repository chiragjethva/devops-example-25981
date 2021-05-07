


resource "aws_instance" "myinstance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key


  subnet_id              = "subnet-c41b9ebc"
  vpc_security_group_ids = [var.sgid]
  tags = {
    Terraform = "true"
    Version   = var.versionname
  }

}

resource "null_resource" "install" {

  triggers = {
    always_run = var.versionname
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = aws_instance.myinstance.public_ip
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sh /tmp/script.sh",
    ]
  }

}


