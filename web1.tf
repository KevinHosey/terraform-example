resource "digitalocean_droplet" "web1" {
  image = "ubuntu-16-04-x64"
  name = "web1"
  region = "nyc3"
  size = "1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    host = "${digitalocean_droplet.web1.ipv4_address}"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
}
