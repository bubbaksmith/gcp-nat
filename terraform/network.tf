resource "google_compute_network" "network1" {
  name                    = "network-1"
  project                 = "nat-dev-1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet-1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.network1.id
  project       = "nat-dev-1"

  depends_on = [resource.google_compute_network.network1]
}

resource "google_compute_firewall" "iap_access" {
  name    = "allow-iap-access"
  network = google_compute_network.network1.self_link
  project = "nat-dev-1"

  priority    = 1000
  direction   = "INGRESS"
  description = "Allow ingress traffic from IAP to the VM"

  source_ranges = ["35.235.240.0/20"]

  source_tags = ["iap-access"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  depends_on = [
    resource.google_compute_subnetwork.subnet1,
  ]

}
