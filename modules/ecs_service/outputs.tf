output "alb_url" {
  value = aws_lb.petclinic_alb.dns_name
}