output "load_balancer_ip" {
  value = module.lb.external_ip
}
output "upload_bucket_name" {
  value = var.create_upload_bucket == true ? module.upload_bucket[0].name : ""
}
output "upload_bucket_url" {
  value = var.create_upload_bucket == true ? module.upload_bucket[0].url : ""
}
output "suffix" {
  value = random_id.suffix.hex
}
output "dns_name" {
  value = var.domain_name == "" || var.dns_record_name == "" || var.dns_managed_zone == "" ? "" : "${local.dns_record_name}${var.domain_name}"
}
output "cloud_run_status" {
  description = "From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app"
  value       = google_cloud_run_service.default.status
}