resource "openstack_images_image_v2" "ubuntu-22" {
  name             = "ubuntu-22"
  local_file_path = "./cloud-images/ubuntu-22.04-server-cloudimg-amd64.img"
# image_source_url = "https://cloud-images.ubuntu.com/jammy/20250207/jammy-server-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility = "public"

  properties = {
    version = "22.04-jammy-2025-02-07"
  }
}


resource "openstack_images_image_v2" "ubuntu-24" {
  name             = "ubuntu-24"
#   image_source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  local_file_path = "./cloud-images/noble-server-cloudimg-amd64.img"  
  container_format = "bare"
  disk_format      = "qcow2"
  visibility = "public"

  properties = {
    version = "24.04-latest"
  }
}

resource "openstack_images_image_v2" "windows-10" {
  name             = "windows-10"
#   image_source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  local_file_path = "./cloud-images/windows-10-iso.img"  
  container_format = "bare"
  disk_format      = "qcow2"
  visibility = "public"

  properties = {
    version = "24.04-latest"
  }
}

resource "openstack_images_image_v2" "centos-9" {
  name             = "centos-stream-9"
  #image_source_url = "https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-20250101.0.x86_64.qcow2"
  local_file_path = "./cloud-images/centos-stream9-modified.img"  
  container_format = "bare"
  disk_format      = "qcow2"

  properties = {
    version = "Centos-9-stream-2025-01-02"
  }
}

# resource "openstack_images_image_v2" "debian-10" {
#   name             = "debian.10"
#   image_source_url = "https://cdimage.debian.org/images/cloud/OpenStack/current-10/debian-10-openstack-amd64.qcow2"
#   container_format = "bare"
#   disk_format      = "qcow2"

#   properties = {
#     version = "current-10"
#   }
# }


# resource "openstack_images_image_v2" "windows" {
#   name             = "debian.10"
#   image_source_url = ""
#   container_format = "bare"
#   disk_format      = "qcow2"

#   properties = {
#     version = "current-10"
#   }
# }
