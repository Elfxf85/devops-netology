terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

 backend "s3" {
 endpoint   = "storage.yandexcloud.net"
 bucket     = "tfstelfxf"
 region     = "ru-central1"
 key        = "terraform.tfstate"

 skip_region_validation  = true
 skip_credentials_validation = true
 dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8h2rh376qfol4bodf/etnl765c7pdep74bfpqr"
 dynamodb_table = "tfstate-develop"

}
}
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

module "vpc_dev" {
  source       = "./vpc"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
  env_name = "develop"
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [module.vpc_dev.subnet_id]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для��3
      serial-port-enable = 1
  }

}

#Пример передачи cloud-config 
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars     = {
    vms_ssh_root_key = file(var.vms_ssh_root_key[0])
  }
}
