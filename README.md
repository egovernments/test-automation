#cmd line arguments for dev
mvn clean test "-Dkarate.env=dev" -DtenantId=uk -Dlocale=en_IN

#cmd line arguments for qa
mvn clean test "-Dkarate.env=qa" -DtenantId=pb -Dlocale=en_IN

#cmd line arguments for uat
mvn clean test "-Dkarate.env=uat" -DtenantId=pb -Dlocale=en_IN 