# Configure the Google Cloud provider
provider "google" {
  project = "sivaram-dev"
  credentials = file("jenkins.json")
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

  metadata_startup_script= <<EOF
    sudo su 
    apt update 
    apt -y install apache2 
    sudo service apache2 start 
    sudo update-rc.d apache2 enable
    echo "Hello World" > /var/www/html/index.html
    echo "Hello world from $(hostname) $(hostname -I)" > /var/www/html/index.html
    EOF

    network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
