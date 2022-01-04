data "template_file" "init" {
  template = file("../frontend/front.sh")
  vars = {
    REACT_APP_BACKEND_URI = "${module.alb-back.lb_dns_name}"
  }
}
