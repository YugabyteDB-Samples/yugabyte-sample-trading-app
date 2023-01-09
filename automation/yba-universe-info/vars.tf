variable "universe-name"{
  description = "Name of the universe"
  type = string
}

variable yba {
  type = object({
    api-endpoint = string
    api-token = string
    insecure = bool
    customer-uuid = string
  })
  description = "YBA Connection Details"
}
