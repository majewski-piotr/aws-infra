variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "state" {
  type = object({
    bucket = string
    keys = object({
      network = string
    })
  })
}
