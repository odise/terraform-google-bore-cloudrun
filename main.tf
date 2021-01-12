locals {
  name_suffix     = var.name_suffix == "" ? "" : "-${var.name_suffix}"
  dns_record_name = var.dns_record_name == "" ? "" : "${var.dns_record_name}."
}
resource "random_id" "suffix" {
  byte_length = 2
  prefix      = "br"
}

module "upload_bucket" {
  count      = var.create_upload_bucket == true ? 1 : 0
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "1.7.2"
  project_id = var.project_id
  names      = [var.upload_bucket_name, ]
  prefix     = var.upload_bucket_prefix
}

module "lb" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 4.5"

  name    = "${var.lb_name}-${random_id.suffix.hex}"
  project = var.project_id

  ssl                             = var.ssl
  managed_ssl_certificate_domains = ["${local.dns_record_name}${var.domain_name}"]
  https_redirect                  = var.ssl

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn             = false
      security_policy        = null
      custom_request_headers = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "${var.name}${local.name_suffix}-serverless-neg-${random_id.suffix.hex}"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project_id
  cloud_run {
    service = google_cloud_run_service.default.name
  }
}

resource "google_cloud_run_service" "default" {
  name     = "${var.cloud_run_service_name}-${random_id.suffix.hex}"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.container_image
        env {
          name  = "BORING_REGISTRY_GCS_BUCKET"
          value = var.create_upload_bucket == true ? module.upload_bucket[0].name : var.upload_bucket_name
        }
        env {
          name  = "BORING_REGISTRY_TYPE"
          value = "gcs"
        }
        env {
          name  = "BORING_REGISTRY_DEBUG"
          value = var.enable_debug_mode
        }
        env {
          name  = "BORING_REGISTRY_GCS_SIGNEDURL"
          value = var.gcs_signedurl
        }
        env {
          name  = "BORING_REGISTRY_GCS_SA_EMAIL"
          value = var.service_account_email
        }
        env {
          name  = "BORING_REGISTRY_GCS_SIGNEDURL_EXPIRY"
          value = var.gcs_signedurl_expiry
        }
        env {
          name  = "BORING_REGISTRY_API_KEY"
          value = join(",", var.api_keys)
        }
        ports {
          container_port = var.container_port
        }
      }
      service_account_name = var.service_account_email
    }
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_dns_record_set" "registry" {
  count   = var.domain_name == "" || var.dns_record_name == "" || var.dns_managed_zone == "" ? 0 : 1
  project = var.project_id
  name    = "${local.dns_record_name}${var.domain_name}."
  type    = "A"
  ttl     = 300

  managed_zone = var.dns_managed_zone

  rrdatas = [module.lb.external_ip]
}