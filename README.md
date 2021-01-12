# terraform-google-bore-cloudrun
This module deploys the [boring-registry](https://github.com/TierMobility/boring-registry) as a Google Cloud Run service.

# Usage
<!--- BEGIN_TF_DOCS ---> 
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.12.6, <0.14 |
| google | ~> 3.51.0 |
| google-beta | ~> 3.51.0 |
| random | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.51.0 |
| google-beta | ~> 3.51.0 |
| random | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_keys | List of static API keys to protect the server with. | `list(string)` | `[]` | no |
| cloud\_run\_service\_name | n/a | `string` | `"boring-registry"` | no |
| container\_image | n/a | `string` | n/a | yes |
| container\_port | n/a | `number` | `5601` | no |
| create\_upload\_bucket | n/a | `bool` | `true` | no |
| dns\_managed\_zone | Name of the Google managed zone the DNS record will be created in. | `string` | `""` | no |
| dns\_record\_name | Record name of the `domain_name` parameter pointing at the load balancer on (e.g. `registry`). Used if `ssl` is `true`. | `string` | `"bore"` | no |
| domain\_name | Domain name to run the load balancer on (e.g. example.com). Used if `ssl` is `true`. | `string` | `""` | no |
| enable\_debug\_mode | n/a | `bool` | `false` | no |
| gcs\_signedurl | n/a | `bool` | `false` | no |
| gcs\_signedurl\_expiry | n/a | `number` | `30` | no |
| lb\_name | Name for load balancer and associated resources | `string` | `"bore-lb"` | no |
| name | Name for load balancer and associated resources | `string` | `"bore"` | no |
| name\_suffix | Add a name suffix to relevant Terraform resources. | `string` | `""` | no |
| project\_id | n/a | `string` | n/a | yes |
| region | Location for load balancer and Cloud Run resources | `string` | `"europe-west3"` | no |
| service\_account\_email | (Optional) Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided, the revision will use the project's default service account (PROJECT\_NUMBER-compute@developer.gserviceaccount.com). | `string` | `""` | no |
| ssl | Run load balancer on HTTPS and provision managed certificate with provided `domain`. | `bool` | `true` | no |
| upload\_bucket\_name | n/a | `string` | `""` | no |
| upload\_bucket\_prefix | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_run\_status | From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app |
| dns\_name | n/a |
| load\_balancer\_ip | n/a |
| suffix | n/a |
| upload\_bucket\_name | n/a |
| upload\_bucket\_url | n/a |

<!--- END_TF_DOCS --->