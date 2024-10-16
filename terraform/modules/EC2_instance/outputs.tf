## Hier definierst du die Ausgaben des Moduls.

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "subnet_string" {
  value = join(", ", var.subnet_ids)  # Nutze die join-Funktion, um die Subnetz-IDs zu verbinden
}
