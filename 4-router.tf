# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router

// Iowa Router
resource "google_compute_router" "iowa-router" {
  name    = "iowa-router"
  region  = "us-central1"
  network = google_compute_network.twismnetwork.id
}

// Tokyo Router
resource "google_compute_router" "tokyo-router" {
  name    = "tokyo-router"
  region  = "asia-northeast1"
  network = google_compute_network.twismnetwork.id
}

// Belgium Router
resource "google_compute_router" "belgium-router" {
  name    = "belgium-router"
  region  = "europe-west1"
  network = google_compute_network.twismnetwork.id
}

// Brazil Router
resource "google_compute_router" "saopaulo-router" {
  name    = "saopaulo-router"
  region  = "southamerica-east1"
  network = google_compute_network.twismnetwork.id
}