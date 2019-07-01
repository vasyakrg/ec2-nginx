output "ip-address" {
  value = "${aws_instance.my_vm.public_ip}"
}
