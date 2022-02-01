provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "project" {
  depends_on = [aws_db_instance.default]
  ami           = "ami-0629230e074c580f2"
  instance_type = "t2.micro"
  subnet_id   = "subnet-08ac816e92386a609"
  key_name = "saiprasad"
  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint,address = aws_db_instance.default.address})
  iam_instance_profile = "sairole"
  security_groups = ["sg-0dc41efd97089dff7"]
  tags = {
    Name = "cpms1"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "cpms"
  identifier           = "basedata1"
  username             = "admin"
  password             = "saiprasadrapeti"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = ["sg-0dc41efd97089dff7"]
}
