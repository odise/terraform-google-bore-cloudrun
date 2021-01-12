variable "project_id" {
  type = string
}
variable "region" {
  description = "Location for load balancer and Cloud Run resources"
  default     = "europe-west3"
  type        = string
}
variable "container_image" {
  type = string
}
