packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.9"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
##PACKER SOURCE##
source "amazon-ebs" "appimage" {
  ami_name      = local.image-name
  source_ami = var.ami
  instance_type = "t2.micro"
  ssh_username = "ec2-user"
  tags  = {
Name = local.image-name
project = var.project_name
env = var.project_env
}
}

build {
  name    = "Build- AMI"
  sources = [
    "source.amazon-ebs.appimage"
  ]

 provisioner "shell" {
   script = "./setup.sh"
execute_command = "sudo {{.Path}}"
}

provisioner "file" {
source = "../website"
destination = "/tmp/"
}


provisioner "shell" {
inline = ["sudo cp -r /tmp/website/* /var/www/html/","sudo chown -R apache:apache /var/www/html/*","sudo rm -rf /tmp/website"]
}
}
