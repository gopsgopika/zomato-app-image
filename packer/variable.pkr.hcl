variable "project_name" {
  type    = string
}

variable "project_env" {
  type    = string
}

variable "ami" {
  type    = string
}

locals {
  image-timestamp = "${formatdate("DD-MM-YYYY-hh-mm-ss", timestamp())}"
  image-name = "${var.project_name}-${var.project_env}-${local.image-timestamp}"

}
