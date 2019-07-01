provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_security_group" "allow_ports" {
  name = "allow-ports"

  ingress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${var.ssh_key}"
}

resource "aws_instance" "my_vm" {
  ami           = "${var.ami}"
  instance_type = "${var.plan}"

  security_groups = ["allow-ports"]
  key_name        = "deployer-key"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo echo '${var.ssh_rebrain_key}' >> /home/ec2-user/.ssh/authorized_keys",
    ]
  }

  connection {
    host        = "${aws_instance.my_vm.public_ip}"
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "local-exec" {
    command = <<EOT
echo '${aws_instance.my_vm.public_ip}' > ansible/hosts;
sleep ${var.ansible_timeout}; cd ansible; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key '~/.ssh/id_rsa' provision.yml;
EOT
  }
}
