resource "google_service_account" "dev_sa" {
  account_id   = "nat-dev-sa"
  display_name = "Custom SA for VM Instance"
  project      = "nat-dev-1"
}

resource "google_compute_instance" "nat-test" {
  name         = "nat-test"
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
    email  = google_service_account.dev_sa.email
    scopes = ["cloud-platform"]
  }

  tags = ["iap-access"]

  depends_on = [
    resource.google_compute_subnetwork.subnet1,
    resource.google_service_account.dev_sa
  ]
}
