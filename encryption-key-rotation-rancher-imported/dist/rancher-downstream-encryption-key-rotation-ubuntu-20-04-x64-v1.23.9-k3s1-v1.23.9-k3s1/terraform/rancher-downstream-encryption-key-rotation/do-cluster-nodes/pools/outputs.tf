output "fqdn" {
  value = join(".", [digitalocean_record.fqdn.name, digitalocean_record.fqdn.domain])
}

output "corral_node_pools" {
  value = {
    local = [for droplet in [digitalocean_droplet.server[0]] : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
    downstream = [for droplet in [digitalocean_droplet.server[1]] : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
  }
}