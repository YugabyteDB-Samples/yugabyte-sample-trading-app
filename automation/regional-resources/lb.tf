
resource "aws_eip" "app" {
  vpc = true
}

resource "aws_lb" "app" {
  name               = "${var.prefix}-nlb"
  load_balancer_type = "network"
  # security_groups = [aws_security_group.lb.id]

  subnet_mapping {
    subnet_id     = data.aws_subnets.public-subnets.ids[0]
    allocation_id = aws_eip.app.id
  }
}


locals{
  app_ports = {
    ssh = 22
    http = 80
    https = 443
    alt_http = 8080
    spring_management = 8081
    alt_https = 8443
  }
}
resource "aws_lb_target_group" "app" {
  for_each = local.app_ports
  name     = "${var.prefix}-${each.value}-tg"
  port     = each.value
  protocol = "TCP"
  vpc_id   = data.aws_vpc.vpc.id
  depends_on = [
    aws_lb.app
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "app" {
  for_each = local.app_ports
  target_group_arn = aws_lb_target_group.app[each.key].arn
  target_id        = aws_instance.app.id
  port             = each.value
  
}

resource "aws_lb_listener" "app" {
  for_each = local.app_ports
  tags = {
    Name = "${var.prefix}-${each.value}"
  }

  load_balancer_arn = aws_lb.app.arn
  protocol          = "TCP"
  port              = each.value

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app[each.key].arn
  }
}



