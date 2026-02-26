packer {
  required_plugins {
    amazon = {
      version = "1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
        ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
  }
}
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "wordpress-ami-{{ timestamp }}"
  instance_type = "t3.micro"
  region        = "us-east-1"
  source_ami = "ami-0030e4319cbf4dbf2"
  ssh_username = "ubuntu"
  ssh_private_key_file = "~/.ssh/id_rsa"
  ssh_keypair_name = "packer-key"
} 

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "main.yml"
  }
}
