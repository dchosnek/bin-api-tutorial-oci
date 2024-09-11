variable "basename" {
  type        = string
  description = "string to be used at start of resource name created"
}

variable "parent_compartment" {
  type        = string
  description = "ID of compartment to use for this project"
}

variable "database_port" {
  type        = number
  description = "TCP port number for database comms"
  default     = 27017
}
