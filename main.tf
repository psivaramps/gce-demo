# Configure the Google Cloud provider
provider "google" {
  project = "envmnt-prod"
  credentials = file("terraform-dev.json")
  region  = "us-central1"
}

# Create a Google Compute instance
resource "google_compute_instance" "terraform-gce" {
  name          = "gce-vm-jenkins"
  machine_type  = "e2-small"
  zone          = "us-central-b"
  tags = ["prod"]
  
  boot_disk {
    initialize_params {
      image = "ubuntu-2210-kinetic-arm64-v20230615"
    }
  }

  # metadata_startup_script= file("startup.sh)
  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      apt update
      set -euo pipefail
      export DEBIAN_FRONTEND=noninteractive
      apt -y install apache2
      cat <<EOF > /var/www/html/index.html
      <html><body><h1>Welcome to MI Institute...!</h1></body></html>
      EOF
      EOF1
  }

    network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
