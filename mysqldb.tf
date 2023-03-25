resource "google_sql_database_instance" "example-instance" {
  name             = "wordprss-instance"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/alert-flames-286515/global/networks/project-vpc"
    }
  }
}


resource "google_sql_database" "example-database" {
  name     = "wordpress"
  instance = google_sql_database_instance.example-instance.name
}

resource "google_service_account" "example_service_account" {
  account_id   = "wordpressserviceaccount"
  display_name = "Wordpress MySQL Service Account"
}

resource "google_project_iam_binding" "example_binding" {
  project = "alert-flames-28651"
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:${google_service_account.example_service_account.email}"
  ]
}