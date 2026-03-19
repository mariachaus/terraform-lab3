

# Глобальні теги для всіх ресурсів
locals {
  common_tags = {
    environment = "lab3"
    owner       = "mariia_chaus"
  }
}

# Створення VPC
resource "google_compute_network" "vpc_lab3" {
  name                    = "vpc-lab3-11"
  auto_create_subnetworks = false
  description             = "VPC for Lab 3"
}

# Підмережі
resource "google_compute_subnetwork" "subnet_a" {
  name          = "subnet-a-lab3-11"
  ip_cidr_range = var.subnet_a_cidr
  network       = google_compute_network.vpc_lab3.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_b" {
  name          = "subnet-b-lab3-11"
  ip_cidr_range = var.subnet_b_cidr
  network       = google_compute_network.vpc_lab3.id
  region        = var.region
}

# Інтернет-шлюз (default route через default-internet-gateway)
resource "google_compute_router" "nat_router" {
  name    = "nat-router-lab3-11"
  network = google_compute_network.vpc_lab3.id
  region  = var.region
}

# Firewall rule для web порту
resource "google_compute_firewall" "allow_web" {
  name    = "allow-web-lab3-11"
  network = google_compute_network.vpc_lab3.id

  allow {
    protocol = "tcp"
    ports    = [var.web_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Динамічний пошук останнього Ubuntu 24.04 LTS образу
data "google_compute_image" "ubuntu" {
  family  = var.vm_image_family
  project = var.vm_image_project
}

# Розгортання VM
resource "google_compute_instance" "vm_lab3" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
    }
  }

  network_interface {
    network    = google_compute_network.vpc_lab3.id
    subnetwork = google_compute_subnetwork.subnet_a.id
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/bootstrap.sh", {
    web_port      = var.web_port
    document_root = var.document_root
    server_name   = var.server_name
  })

  tags = ["web-server"]

  labels = local.common_tags
}