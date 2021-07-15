#!/bin/sh

if [ ($1 != "") && (-e $1)]
then
    if [ ($3 != "") && (toLower($3) == y) ]
    then
        if [ ($4 != "") && (-e $4)]
        then
            mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@uiServices" "-DbrowserConfig=$4"
        else
            echo "Browser config file does not exists! Please re run the command with correct path!"
            exit 1
        fi
    else
        mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@coreServices"
        mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@businessServices"
        mvn clean install "-DconfigPath=$1" "-Dtags=$2" "-Dservices=@municipalServices"
    fi
else
    echo "Environment config file does not exists! Please re run the command with correct path!"
    exit 1
fi