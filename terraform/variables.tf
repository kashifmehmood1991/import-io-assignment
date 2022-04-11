variable "region" {
  default = "eu-central-2"
}

variable "instance_type" {
  type = string
}

variable "identifier" {
  type = string
}

variable "tags" {
  type = object({
    project = string
    }
  )
}
