resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  # oder der Benutzer, der für deine AMI-ID relevant ist
      private_key = file("~/.ssh/your_private_key.pem")  # Pfad zu deinem SSH-Schlüssel
      host        = self.public_ip
    }
  }
}
