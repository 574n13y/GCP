
variable "path" {default = "/home/terraform/credentials"}

provider "google" {
    project = "festive-zoo-239708"
    region = "europe-west2-a"
    credentials = "${file("${var.path}/secrets.json")}"
}




install jq 
kube app API
compute account - OWNER
