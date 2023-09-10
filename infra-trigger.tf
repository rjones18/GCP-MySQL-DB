resource "google_cloudbuild_trigger" "example" {
  project = "alert-flames-286515"
  name    = "WP-SQL-Trigger"
  disabled = false
  service_account = "projects/alert-flames-286515/serviceAccounts/cloudbuild.gserviceaccount.com"

  trigger_template {
    repo_name   = "github_rjones18_gcp-mysql-db"
    branch_name = "main"
  }
  filename = "cloudbuild.yaml"
}