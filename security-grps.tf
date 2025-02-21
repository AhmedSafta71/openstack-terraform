resource "openstack_networking_secgroup_v2" "db_sg" {
  name        = "db_sg"
  description = "Database Security Group security group"
   
}
resource "openstack_networking_secgroup_v2" "web_sg" {
  name        = "web_sg"
  description = "Web security Group"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_db_rule_v4" {
  
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = local.client_ip
  security_group_id = openstack_networking_secgroup_v2.db_sg.id 
  description = "Enable ssh traffic from specific ip address"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_web_rule_v4" {
  
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = local.client_ip
  security_group_id = openstack_networking_secgroup_v2.web_sg.id
  description = "Enable ssh traffic from specific ip address"
}

resource "openstack_networking_secgroup_rule_v2" "http_rule_v4" {
  
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = local.client_ip
  security_group_id = openstack_networking_secgroup_v2.web_sg.id 
  description = "Enable http traffic from specific ip address"
}
#http  traffic 
resource "openstack_networking_secgroup_rule_v2" "mysql_rule_v4" {
  
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_group_id = openstack_networking_secgroup_v2.web_sg.id 
  security_group_id = openstack_networking_secgroup_v2.web_sg.id 
  description = "Enable Mysql traffic from the web security group"
}