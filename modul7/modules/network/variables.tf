variable "name_prefix" {
  description = "Prefiks for alle ressursnavn i modulen"
  type        = string
}

variable "location" {
  description = "Azure-region"
  type        = string
}

variable "resource_group_name" {
  description = "Navnet på ressursgruppen modulen skal bruke"
  type        = string
}
