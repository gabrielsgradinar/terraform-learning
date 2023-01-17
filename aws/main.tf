resource "aws_iam_user" "admin-user" {
  name = "julia"
  tags = {
    "Description" = "Technical Team Leader"
  }
}

resource "aws_iam_policy" "adminUser" {
  name   = "AdminUsers"
  policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "julia-admin-access" {
  user       = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser.arn
}

resource "aws_s3_bucket" "finance" {
  bucket = "finance-13012023"
  tags = {
    "Description" = "Finance and Payroll"
  }
}

resource "aws_s3_object" "finance-2023" {
  content = "./root/finance.txt"
  key     = "finance-2023.txt"
  bucket  = aws_s3_bucket.finance.id
}

data "aws_iam_group" "finance-data" {
  group_name = "finance-analysts"
}

# resource "aws_s3_bucket_policy" "finance-policy" {
#   bucket = aws_s3_bucket.finance.id
#   policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Action" : "*",
#           "Effect" : "Allow",
#           "Resource" : "arn:aws:s3:::${aws_s3_bucket.finance.id}/*"
#           "Principal" : {
#             "AWS" : [
#               "${data.aws_iam_group.finance-data.arn}"
#             ]
#           }
#         }
#       ]
#     }
#   )
# }

resource "aws_dynamodb_table" "cars" {
  name         = "cars"
  hash_key     = "VIN"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "VIN"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "car-items" {
  table_name = aws_dynamodb_table.cars.name
  hash_key   = aws_dynamodb_table.cars.hash_key
  item = jsonencode(
    {
      "Manufacturer" : { "S" : "Toyota" },
      "Make" : { "S" : "Corolla" },
      "Year" : { "N" : "2004" },
      "VIN" : { "S" : "4YISL65848Z411439" },
    }
  )
}

resource "aws_instance" "webserver" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"

  tags = {
    "Name"        = "webserver"
    "Description" = "An Nginx WebServer on Ubuntu"
  }

  provisioner "local-exec" {
    command = "echo Instance ${aws_instance.webserver.public_ip} created ! >> ./root/ip.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo Instance ${self.public_ip} destroyed ! >> ./root/ip.txt"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              EOF

  vpc_security_group_ids = [aws_security_group.ssh-access.id]

}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH access from the internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip
}
