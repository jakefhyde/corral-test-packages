variable "corral_name" {} // name of the corral being created
variable "corral_user_id" {} // how the user is identified (usually github username)
variable "corral_public_key" {} // The corrals public key.  This should be installed on every node.

// Package
variable "digitalocean_token" {}
variable "digitalocean_domain" {}
variable "image" {}
variable "size" {}
variable "etcd_count" {}
variable "controlplane_count" {}
variable "worker_count" {}
