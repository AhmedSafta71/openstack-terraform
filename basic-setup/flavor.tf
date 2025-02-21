resource "openstack_compute_flavor_v2" "t2-nano" {
  name  = "t2.nano"
  ram   = "512"
  vcpus = "1"
  disk  = "10"
  description = "512-1-10"
  region = "RegionOne"
  is_public = true

}
resource "openstack_compute_flavor_v2" "t2-micro" {
  name  = "t2.micro"
  ram   = "1024"
  vcpus = "1"
  disk  = "10"
  description = "1024-1-10"
  region = "RegionOne"
  is_public = true
}
resource "openstack_compute_flavor_v2" "t2-small" {
  name  = "t2.small"
  ram   = "2048"
  vcpus = "1"
  disk  = "10"
  description = "2048-1-10"
  region = "RegionOne"
  is_public = true

}
resource "openstack_compute_flavor_v2" "t2-medium" {
  name  = "t2.medium"
  ram   = "4096"
  vcpus = "2"
  disk  = "10"
  description = "4096-2-10"
  region = "RegionOne"
  is_public = true

}
resource "openstack_compute_flavor_v2" "t2-large" {
  name  = "t2.large"
  ram   = "8192"
  vcpus = "2"
  disk  = "10"
  description = "8192-2-10"
  region = "RegionOne"
  is_public = true
}