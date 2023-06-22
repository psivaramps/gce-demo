# Configure the Google Cloud provider
provider "google" {
  project = "mytraining-gcptech "
  region  = "us-east1-b"
}

# Create a Google Compute instance
resource "google_compute_instance" "terraform-gce" {
  name          = "success"
  machine_type  = "f1-micro"
  zone          = "us-east1-b"
  tags = ["prod"]
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
