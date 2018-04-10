provider "aws" {
  /* normalmente usariamos las llaves de aws pero exportamos las credenciales
       usando "export" por lo tanto no es necesario usarlas aqui */
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-name"
  instance_type = "t2.micro"

  tags {
    Name = "terra-bb"
  }
}
