# Configure the Google Cloud provider
provider "google" {
  project = "samad-450009"
  region  = "us-central1"
}

# Create a Google Compute instance
resource "google_compute_instance" "example" {
  name          = "example"
  machine_type  = "f1-micro"
  zone          = "us-central1-a"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  
  tags = ["terraform-example"]
}
# Output the external IP of the instance
output "vm_external_ip" {
  description = "The external IP address of the VM instance"
  value       = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}

# Output the internal IP of the instance
output "vm_internal_ip" {
  description = "The internal IP address of the VM instance"
  value       = google_compute_instance.example.network_interface[0].network_ip
}
