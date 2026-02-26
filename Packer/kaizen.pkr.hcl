packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "kaizen-ami-{{ timestamp }}"
  instance_type = "t3.micro"
  region        = "us-east-1"
  source_ami = "ami-0f3caa1cf4417e51b"
  ssh_username = "ec2-user"
  ssh_private_key_file = "~/.ssh/id_rsa"
  ssh_keypair_name = "packer-key"
} 

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "apache.sh"
  }
}
