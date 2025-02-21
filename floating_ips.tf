resource "openstack_compute_floatingip_v2" "web_1_fip" {
  pool = "provider"
}
resource "openstack_compute_floatingip_v2" "web_2_fip" {
  pool = "provider"
}
resource "openstack_compute_floatingip_v2" "db_fip" {
  pool = "provider"
}

resource "openstack_compute_floatingip_associate_v2" "web_1_associate" {
  depends_on = [ openstack_compute_instance_v2.web-instance ]
  floating_ip = openstack_compute_floatingip_v2.web_1_fip.address
  instance_id = openstack_compute_instance_v2.web-instance[0].id
}
resource "openstack_compute_floatingip_associate_v2" "web_2_associate" {
  depends_on = [ openstack_compute_instance_v2.web-instance ]
  floating_ip = openstack_compute_floatingip_v2.web_2_fip.address
  instance_id = openstack_compute_instance_v2.web-instance[1].id
}

resource "openstack_compute_floatingip_associate_v2" "db_associate" {
  floating_ip = openstack_compute_floatingip_v2.db_fip.address
  instance_id = openstack_compute_instance_v2.db-instance.id
}