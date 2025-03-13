resource "aws_lb" "nlb" {
  name               = "compute-private"
  internal           = true
  load_balancer_type = "network"
  subnets            =  values(aws_subnet.edge)[*].id
}