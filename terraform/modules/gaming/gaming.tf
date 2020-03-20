data "aws_ami" "gaming" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["gaming-*"]
  }
}

# I intentionally do not set the spot_price value because it defaults to the
# on-demand price. Based on my experience, this means I'm paying more than the
# average spot price. However, unless spot prices increase beyond the on-demand
# price, this will always be fulfilled.
resource "aws_spot_instance_request" "gaming" {
  ami           = data.aws_ami.gaming.id
  ebs_optimized = "false"
  instance_type = "g4dn.xlarge"
  key_name      = "primary"
  subnet_id     = var.subnet_id

  # Wait until the spot request is fulfilled. This should be fairly quick, so
  # if it takes a long time (minutes), then it should indicate a potential spot
  # instance shortage.
  wait_for_fulfillment = true

  # This allows me to take a snapshot of the instance and delete the
  # provisioned volume.
  instance_initiated_shutdown_behavior = "stop"

  # Do not request another instance fulfilment after this instance is
  # terminated.
  spot_type = "one-time"

  vpc_security_group_ids = [
    var.gaming_sg_id,
    var.egress_sg_id,
  ]

  tags = {
    Name = "gaming"
  }
}

resource "aws_eip_association" "gaming_eip_allocation_id" {
  instance_id   = aws_spot_instance_request.gaming.spot_instance_id
  allocation_id = var.gaming_eip_allocation_id
}
