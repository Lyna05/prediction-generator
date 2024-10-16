## Hier definierst du die Variablen, die für das Modul benötigt werden.

variable "ami_id" {
  description = "AMI ID für die EC2-Instanz"
  type        = string
}

variable "instance_type" {
  description = "Instanztyp der EC2-Instanz"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name der EC2-Instanz"
  type        = string
}

variable "subnet_ids" {
  description = "Liste der Subnetz-IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Sicherheitsgruppen-ID für die EC2-Instanz"
  type        = string
}
