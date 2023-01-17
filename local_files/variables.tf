variable "filename" {
  default = [
    "./root/pets.txt",
    "./root/dogs.txt",
    "./root/cats.txt"
  ]
  type        = list(string)
  description = "the path os local file"
}

variable "content" {
  type = map(any)
  default = {
    "statement1" = "We love pets!"
    "statement2" = "We love animals!"
  }
}

variable "prefix" {
  default = ["Mrs", "Mr", "Sir"]
  type    = list(string)
}

variable "separator" {
  default = "."
}

variable "length" {
  default = "2"
}
