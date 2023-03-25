# data "google_compute_network" "vpc_network" {
#   name = "project-vpc"
# }

# data "google_compute_subnetwork" "subnet" {
#   name = "app-subnet-1"
#   region = "us-central1"
# }

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