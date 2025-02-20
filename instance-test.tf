resource "openstack_compute_instance_v2" "test" {
  name            = "terraform-test"
  image_id        = data.openstack_images_image_ids_v2.ubuntu.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.medium.id
  key_pair        = "machines-key"
  security_groups = ["db-sg"]


  metadata = {
    app = "database"
  }

  network {
    name = "private"
  }
}