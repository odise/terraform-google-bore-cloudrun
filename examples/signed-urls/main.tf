module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  prefix        = module.example.suffix
  names         = ["boring-registry"]
  project_roles = ["${var.project_id}=>roles/editor", "${var.project_id}=>roles/iam.serviceAccountTokenCreator"]
  display_name  = "boring registry cloud run service account"
  #  description   = "Single Account Description"
}

module "example" {
  source = "../.."

  project_id             = var.project_id
  region                 = var.region
  ssl                    = false
  dns_record_name        = ""
  domain_name            = ""
  dns_managed_zone       = ""
  name                   = "bore"
  name_suffix            = ""
  lb_name                = "bore"
  container_image        = var.container_image
  upload_bucket_name     = "boring-registry-example"
  create_upload_bucket   = true
  upload_bucket_prefix   = ""
  enable_debug_mode      = true
  container_port         = 5601
  gcs_signedurl          = true
  cloud_run_service_name = "boring-registry-example"
  service_account_email  = module.service_accounts.email
  gcs_signedurl_expiry   = 30
}