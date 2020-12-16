#cmd line arguments for dev
mvn clean test "-Dkarate.env=dev"

#cmd line arguments for qa
mvn clean test "-Dkarate.env=qa"

#cmd line arguments for uat
mvn clean test "-Dkarate.env=uat"