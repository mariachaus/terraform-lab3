output "vm_name" {
  value       = google_compute_instance.vm_lab3.name
  description = "The name of the VM instance"
}

output "vm_ip" {
  value       = google_compute_instance.vm_lab3.network_interface[0].access_config[0].nat_ip
  description = "External IP address of the VM"
}

output "vm_image" {
  value       = data.google_compute_image.ubuntu.name
  description = "Ubuntu image used for the VM"
}

output "website_url" {
  value       = "http://${google_compute_instance.vm_lab3.network_interface[0].access_config[0].nat_ip}:${var.web_port}/"
  description = "URL to access the deployed website"
}