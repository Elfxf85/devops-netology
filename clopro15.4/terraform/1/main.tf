resource "yandex_vpc_network" "my_vpc" {
  name                = var.VPC_name
}

resource "yandex_vpc_subnet" "public_subnet" {
  name                = var.subnet_name
  v4_cidr_blocks      = var.v4_cidr_blocks
  zone                = var.subnet_zone
  network_id          = yandex_vpc_network.my_vpc.id
}


resource "yandex_vpc_subnet" "private_subnet" {
  count               = length(var.private_subnet_zones)
  name                = "${var.private_subnet_name}-${var.private_subnet_zones[count.index]}"
  v4_cidr_blocks      = [cidrsubnet(var.private_v4_cidr_blocks[0], 4, count.index)]
  zone                = var.private_subnet_zones[count.index]
  network_id          = yandex_vpc_network.my_vpc.id
}

resource "yandex_vpc_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for MySQL access"
  network_id  = yandex_vpc_network.my_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_mdb_mysql_cluster" "example" {
  name                = var.cluster_name
  environment         = var.cluster_env
  network_id          = yandex_vpc_network.my_vpc.id
  security_group_ids  = [yandex_vpc_security_group.my_security_group.id]
  version             = var.version_mysql
  deletion_protection = var.deletion_protection

  
  backup_window_start {
    hours   = var.hours
    minutes = var.minutes
  }

  maintenance_window {
    type = "ANYTIME"
  }

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = var.private_subnet_zones
    content {
      zone      = host.value
      subnet_id = element(yandex_vpc_subnet.private_subnet[*].id, index(var.private_subnet_zones, host.value))
    }
  }
}

resource "yandex_mdb_mysql_database" "my_database" {
  name         = var.database_name
  cluster_id   = yandex_mdb_mysql_cluster.example.id
}

resource "yandex_mdb_mysql_user" "app" {
  cluster_id   = yandex_mdb_mysql_cluster.example.id
  name         = var.user_name
  password     = var.user_password
  permission {
    database_name = var.database_name
    roles         = var.user_roles
  }
}



resource "yandex_vpc_route_table" "private_route_table" {
  network_id = yandex_vpc_network.my_vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_primary_v4_address
  }
}
