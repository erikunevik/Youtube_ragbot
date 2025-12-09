variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "swedencentral"
}

variable "prefix_app_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "AIchatbot"
}

variable "owner" {
  description = "Name of owner"
  type        = string
  default     = "Erik Unevik"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}

locals {
  common_tags = {
    owner = var.owner
  }
}

variable "openai_api_key" {
  description = "OpenAI API key"
  type        = string
  sensitive   = true
}