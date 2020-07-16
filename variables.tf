variable "users" {
  type = list(string)
   default = ["N", "B", "NU"]
}

variable "create_user" {
    type = string
    default = true // if false it will not create users
}

variable "developers" {
    type = bool
    default = true
}

variable "name" {
    type = string
    default = ""
}

variable "group_users" {
  
  type        = list(string)
  default     = []
}