resource "google_project_service" "compute_api" {
  project = "nat-dev-1"
  service = "compute.googleapis.com"

  disable_on_destroy = false
}
