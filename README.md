#cmd line arguments for dev
mvn clean test "-Dkarate.env=dev"

#cmd line arguments for qa
mvn clean test "-Dkarate.env=qa"

#cmd line arguments for uat
mvn clean test "-Dkarate.env=uat"

User Creation Approach :
	1. Run create user service.
	2. Run search user.
		a. Check whether already user present or not.
		b. If user is already present in the system then should not create a new user.
		c. If user is not present in the system then create the user.
	3. Created user can send it to the next service calls.