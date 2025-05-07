# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

# https://www.economize.cloud/resources/gcp/regions-zones-map


// HQ
resource "google_compute_subnetwork" "twism-hq" {
  name                     = "twism-hq"
  ip_cidr_range            = "10.32.10.0/24" // good idea to destroy and wait first before applying the same ip-address
  region                   = "us-central1"
  network                  = google_compute_network.twismnetwork.id // this network changes based on the name of the vpc (uses dot notation)
  private_ip_google_access = true
}

// Tokyo
resource "google_compute_subnetwork" "tokyo1" {
  name                     = "tokyo1"
  ip_cidr_range            = "10.32.51.0/24"
  region                   = "asia-northeast1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "tokyo2" {
  name                     = "tokyo2"
  ip_cidr_range            = "10.32.52.0/24"
  region                   = "asia-northeast1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "tokyo3" {
  name                     = "tokyo3"
  ip_cidr_range            = "10.32.53.0/24"
  region                   = "asia-northeast1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}

// Saopaulo
resource "google_compute_subnetwork" "saopaulo1" {
  name                     = "saopaulo1"
  ip_cidr_range            = "10.32.90.0/24"
  region                   = "southamerica-east1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}

// Belgium
resource "google_compute_subnetwork" "belgium1" {
  name                     = "belgium1"
  ip_cidr_range            = "10.32.151.0/24"
  region                   = "europe-west1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "belgium2" {
  name                     = "belgium2"
  ip_cidr_range            = "10.32.152.0/24"
  region                   = "europe-west1"
  network                  = google_compute_network.twismnetwork.id
  private_ip_google_access = true
}