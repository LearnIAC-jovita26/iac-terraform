variable "name_prefix" {
  description = "Prefiks for alle ressursnavn i modulen"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.name_prefix))
    error_message = "name_prefix må være 3-20 tegn og bare inneholde små bokstaver, tall og bindestrek."
  }
}

variable "location" {
  description = "Azure-region"
  type        = string
}

variable "resource_group_name" {
  description = "Navnet på ressursgruppen modulen skal bruke"
  type        = string
}
