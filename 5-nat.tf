# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address

// Iowa NAT
## start Iowa NAT
resource "google_compute_router_nat" "iowa-nat" {
  name   = "iowa-nat"
  router = google_compute_router.iowa-router.name
  region = "us-central1"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.twism-hq.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region = "us-central1"
}
## end Iowa NAT

// Tokyo Nat
## start Tokyo Nat
resource "google_compute_router_nat" "tokyo-nat" {
  name   = "tokyo-nat"
  router = google_compute_router.tokyo-router.name
  region = "asia-northeast1"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.tokyo1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.tokyo-nat.self_link]
}

resource "google_compute_address" "tokyo-nat" {
  name         = "tokyo-nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region = "asia-northeast1"
}
## end Tokyo Nat