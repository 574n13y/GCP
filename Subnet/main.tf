resource "google_compute_network" "stanley" {
    name = "stanley-network"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "network" {
    name = "stanley-subnetwork"
    ip_cidr_range = "10.2.0.0/16"
    region = "us-central1"
    network = "${google_compute_network.stanley.self_link}"
}
