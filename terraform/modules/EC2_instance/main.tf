## Hier definierst du die Ressourcen, die deine EC2-Instanz beschreiben.

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  tags = {
    Name = var.instance_name
  }

  subnet_id              = var.subnet_ids[0]  # Verwende das erste Subnetz aus der Liste
  vpc_security_group_ids = [var.security_group_id]  # Sicherheitsgruppe

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
      private_key = file("C:/Users/Lyne/.ssh/my-new-key.pem.pub")  # Pfad zu deinem SSH-Schlüssel
      host        = self.public_ip
    }
  }
}

resource "null_resource" "notify" {
  provisioner "local-exec" {
    command = "echo 'Terraform-Ausführung abgeschlossen!'"
  }
}
