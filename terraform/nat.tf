resource "google_service_account" "nat_sa" {
  account_id = "nat-sa"
  project    = "nat-dev-1"
}

resource "google_compute_address" "nat_address" {
  name         = "nat1"
  address_type = "INTERNAL"
  region       = "us-central1"
  project      = "nat-dev-1"
  subnetwork   = resource.google_compute_subnetwork.subnet1.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance" "nat1" {
  name           = "nat1"
  machine_type   = "e2-micro"
  zone           = "us-central1-a"
  project        = "nat-dev-1"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = resource.google_compute_subnetwork.subnet1.id
    network_ip = google_compute_address.nat_address.address
    access_config {}
  }

  service_account {
    email  = google_service_account.instance_sa.email
    scopes = ["cloud-platform"]
  }

  # metadata = {
  #   startup-script-iptables-sh = file("startup_script_iptables.sh")
  # }
  # metadata_startup_script = file("startup_script.sh")

  tags = ["iap-access"]

  depends_on = [
    resource.google_compute_subnetwork.subnet1,
    resource.google_service_account.nat_sa
  ]
}
