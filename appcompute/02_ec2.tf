# This Powerbi EC2, provisions only for EC2

resource "aws_key_pair" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  key_name   = "qs-${var.environment}-${var.region_suffix}-powerbi-kp-${var.project_version}"
  public_key = var.environment == "stg" ? file("./stg_id_rsa.pub") : file("./id_rsa.pub")
}

resource "aws_eip" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  instance = aws_instance.this[count.index].id
  domain   = "vpc"
}

resource "aws_instance" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  ami                    = "ami-04cee84e703e9473e"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.this[count.index].key_name
  subnet_id              = var.ec2_subnet_id
  vpc_security_group_ids = [aws_security_group.this[count.index].id]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "qs-${var.environment}-${var.region_suffix}-powerbi-${var.project_version}"
  }
}

resource "aws_security_group" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  name        = "allow_rdp"
  description = "Allow RDP inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_rdp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  security_group_id = aws_security_group.this[count.index].id
  cidr_ipv4         = var.ec2_CIDR
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

resource "aws_vpc_security_group_egress_rule" "this" {
  count = var.environment == "prd" || var.environment == "stg" ? 1 : 0

  security_group_id = aws_security_group.this[count.index].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
