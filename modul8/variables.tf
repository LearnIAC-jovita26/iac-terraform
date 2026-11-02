variable "student_id" {
  description = "Din unike student-ID. Brukes som prefiks i alle ressursnavn."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.student_id))
    error_message = "student_id må være 3-8 tegn og kun inneholde små bokstaver og tall."
  }
}

variable "project" {
  description = "Kort prosjektnavn brukt i ressursnavn"
  type        = string
  default     = "iac"

  validation {
    condition     = length(var.project) <= 10
    error_message = "Prosjektnavnet kan ikke være lengre enn 10 tegn."
  }
}

variable "location" {
  description = "Azure-region for ressursene. Må være en av de tillatte regionene i vår tenant."
  type        = string
  default     = "norwayeast"

  validation {
    condition     = contains(["northeurope", "uksouth", "westeurope", "norwayeast", "norwaywest"], var.location)
    error_message = "location må være en av: northeurope, uksouth, westeurope, norwayeast, norwaywest."
  }
}
