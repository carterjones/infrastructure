resource "aws_eip" "gaming" {
  vpc = true

  tags = {
    Name = "gaming"
  }
}
