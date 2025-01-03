resource "google_service_account" "instance_sa" {
  account_id = "instance-sa"
  project    = "nat-dev-1"
}

resource "google_compute_instance" "instance1" {
  name         = "instance1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  project      = "nat-dev-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = resource.google_compute_subnetwork.subnet1.id
  }

  service_account {
    email  = google_service_account.instance_sa.email
    scopes = ["cloud-platform"]
  }

  tags = ["iap-access", "nat-gateway"]

  depends_on = [
    resource.google_compute_subnetwork.subnet1,
    resource.google_service_account.instance_sa
  ]
}
