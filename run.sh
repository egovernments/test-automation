#!/bin/sh
rm -rf reports
mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@coreServices"
mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@businessServices"
mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@municipalServices"