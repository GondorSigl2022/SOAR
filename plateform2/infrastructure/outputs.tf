output "elb_dns_front_name" {
  value = module.alb-front.lb_dns_name
}

output "elb_dns_back_name" {
  value = module.alb-back.lb_dns_name
}
