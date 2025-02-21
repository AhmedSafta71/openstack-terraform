# Data for images 
data "openstack_images_image_ids_v2" "ubuntu" {
  name = "ubuntu-server-modified"
}
# Data for flavor

data "openstack_compute_flavor_v2" "medium" {
  name = "t2.small"
}

output "debug_image_id" {
  value = data.openstack_images_image_ids_v2.ubuntu
}