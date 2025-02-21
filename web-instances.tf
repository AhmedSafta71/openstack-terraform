resource "openstack_compute_instance_v2" "db-instance" {
  name            = "db-instance"
  image_id        = data.openstack_images_image_ids_v2.ubuntu.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.medium.id
  key_pair        = "machines-key"
  security_groups = [openstack_networking_secgroup_v2.db_sg.id]
  user_data = file("./web-services-config/db-user-data.sh")
  network {
    name = "private"
    fixed_ip_v4 = "10.10.0.25"
  }
  tags = [ "app:database","owner:Ahmed","project:INSA-test-openstack"]
}

resource "openstack_compute_instance_v2" "web-instance" {
  count = 2
  name            = "web-instance-${count.index}"
  image_id        = data.openstack_images_image_ids_v2.ubuntu.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.medium.id
  key_pair        = "machines-key"
  security_groups = [openstack_networking_secgroup_v2.web_sg.id]
  user_data = file("./web-services-config/www-user-data.sh")

  network {
    name = "private"
  }
    tags = [ "app:web","owner:Ahmed","project:INSA-test-openstack"]
     
  
}