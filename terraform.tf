provider "aws" {
	  region = "us-east-2"
	}
	resource "aws_instance" "myec2" {
	  ami           = "ami-0fb653ca2d3203ac1"
	  instance_type = "t2.micro"
	  subnet_id   = "subnet-08ac816e92386a609"
	  key_name = "saiprasad"
	  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint})
	  iam_instance_profile = "My_iam_role1"
	  security_groups = ["sg-00e8a717c46ebd9f2"]
	  tags = {
	    Name = "prasad"
	  }
	}
	resource "aws_db_instance" "default" {
	  allocated_storage    = 10
	  engine               = "mysql"
	  engine_version       = "5.7"
	  instance_class       = "db.t2.micro"
	  name                 = "prasad"
	  identifier           = "myrds"
	  username             = "admin"
	  password             = "saiprasadrapeti"
	  parameter_group_name = "default.mysql5.7"
	  skip_final_snapshot  = true
	  publicly_accessible  = true
	  vpc_security_group_ids = ["sg-00e8a717c46ebd9f2"]
	}
