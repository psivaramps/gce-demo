# Configure the Google Cloud provider
provider "google" {
  project = "envmnt-dev"
  credentials = file("terraform-dev.json")
  region  = "us-east1-b"
}

# Create a Google Compute instance
resource "google_compute_instance" "terraform-gce" {
  name          = "gce-vm-jenkins"
  machine_type  = "e2-small"
  zone          = "us-east1-b"
  tags = ["prod"]
  
  boot_disk {
    initialize_params {
      image = "ubuntu-2210-kinetic-arm64-v20230615"
    }
  }

  metadata_startup_script= file("startup.sh)

    network_interface {
    network = "vpc-automode"

    access_config {
      // Ephemeral IP
    }
  }
}
