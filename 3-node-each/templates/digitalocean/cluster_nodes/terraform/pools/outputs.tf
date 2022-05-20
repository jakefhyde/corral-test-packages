output "fqdn" {
  value = join(".", [digitalocean_record.fqdn.name, digitalocean_record.fqdn.domain])
}

output "corral_node_pools" {
  value = {
    bastion = [for droplet in [digitalocean_droplet.etcd[0]] : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
    etcd = [for droplet in digitalocean_droplet.etcd : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
    controlplane = [for droplet in digitalocean_droplet.controlplane : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
    worker = [for droplet in digitalocean_droplet.worker : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
    encryption_leader = [for droplet in [digitalocean_droplet.controlplane[0]] : {
      name = droplet.name // unique name of node
      user = "root" // ssh username
      address = droplet.ipv4_address // address of ssh host
    }]
  }
}