data "google_secret_manager_secret_version" "my_user_secret" {
  provider = google-beta
  secret   = "wordpress-username"
  version  = "1"
  project  = "alert-flames-286515"
}

data "google_secret_manager_secret_version" "my_db_secret" {
  provider = google-beta
  secret   = "wordpress-db-password"
  version  = "1"
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



resource "google_sql_user" "users" {
  name     = data.google_secret_manager_secret_version.my_user_secret.secret
  instance = google_sql_database_instance.example-instance.name
  password = data.google_secret_manager_secret_version.my_db_secret.secret
  host = "10.0.2.0/23"
}

