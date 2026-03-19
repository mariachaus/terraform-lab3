variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
}

variable "zone" {
  description = "GCP zone for VM"
  type        = string
}

# Мережа та підмережі
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for subnet A"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for subnet B"
  type        = string
}

# Віртуальна машина
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_machine_type" {
  description = "Machine type for VM"
  type        = string
  default     = "e2-medium"
}

variable "vm_image_family" {
  description = "Ubuntu image family"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "vm_image_project" {
  description = "Project for the VM image"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "web_port" {
  description = "TCP port for web server"
  type        = number
}

# S3 bucket для стану Terraform
variable "tf_state_bucket" {
  description = "GCS bucket for Terraform state"
  type        = string
}

variable "tf_state_key" {
  description = "Path to the tfstate file inside the bucket"
  type        = string
}

# Apache customization
variable "server_name" {
  description = "ServerName for Apache"
  type        = string
}

variable "document_root" {
  description = "Document root for Apache"
  type        = string
}