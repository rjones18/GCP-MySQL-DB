data "google_secret_manager_secret_version" "my_user_secret" {
  provider = google-beta
  secret   = "wordpress-username"
  version  = "latest"
  project  = "alert-flames-286515"
}

data "google_secret_manager_secret_version" "my_db_secret" {
  provider = google-beta
  secret   = "wordpress-db-password"
  version  = "latest"
  project  = "alert-flames-286515"
}

resource "google_sql_database" "example-database" {
  name     = "wordpress"
  instance = google_sql_database_instance.example-instance.name
}

resource "google_sql_database_instance" "example-instance" {
  name                = "wordpress-instance"
  database_version    = "MYSQL_5_7"
  region              = "us-central1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/alert-flames-286515/global/networks/project-vpc"

    }
  }
}



# resource "google_sql_user" "users" {
#   name     = data.google_secret_manager_secret_version.my_user_secret.secret
#   instance = google_sql_database_instance.example-instance.name
#   password = data.google_secret_manager_secret_version.my_db_secret.secret
# }

# resource "google_service_account" "example_service_account" {
#   account_id   = "wordpress-service-account"
#   display_name = "Example Service Account"
# }


# resource "google_project_iam_binding" "example_binding" {
#   project = "alert-flames-286515"
#   role    = "roles/cloudsql.client"

#   members = [
#     "serviceAccount:${google_service_account.example_service_account.email}"
#   ]
# }