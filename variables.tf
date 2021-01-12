variable "project_id" {
  type = string
}

variable "region" {
  description = "Location for load balancer and Cloud Run resources"
  default     = "europe-west3"
  type        = string
}

variable "ssl" {
  description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`."
  type        = bool
  default     = true
}
variable "dns_record_name" {
  description = "Record name of the `domain_name` parameter pointing at the load balancer on (e.g. `registry`). Used if `ssl` is `true`."
  type        = string
  default     = "bore"
}
variable "domain_name" {
  description = "Domain name to run the load balancer on (e.g. example.com). Used if `ssl` is `true`."
  type        = string
  default     = ""
}
variable "dns_managed_zone" {
  default     = ""
  type        = string
  description = "Name of the Google managed zone the DNS record will be created in."
}

variable "name" {
  description = "Name for load balancer and associated resources"
  type        = string
  default     = "bore"
}
variable "name_suffix" {
  default     = ""
  type        = string
  description = "Add a name suffix to relevant Terraform resources."
}

variable "lb_name" {
  description = "Name for load balancer and associated resources"
  default     = "bore-lb"
  type        = string
}

variable "container_image" {
  type = string
}

variable "upload_bucket_name" {
  type    = string
  default = ""
}

variable "create_upload_bucket" {
  default = true
  type    = bool
}
variable "upload_bucket_prefix" {
  default = ""
  type    = string
}
variable "enable_debug_mode" {
  type    = bool
  default = false
}
variable "api_keys" {
  description = "List of static API keys to protect the server with."
  default     = []
  type        = list(string)
}
variable "container_port" {
  default = 5601
  type    = number
}
variable "gcs_signedurl" {
  type    = bool
  default = false
}
variable "gcs_signedurl_expiry" {
  default = 30
  type    = number
}
variable "cloud_run_service_name" {
  type    = string
  default = "boring-registry"
}
variable "service_account_email" {
  type        = string
  description = "(Optional) Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided, the revision will use the project's default service account (PROJECT_NUMBER-compute@developer.gserviceaccount.com)."
  default     = ""
}
