#!/bin/bash
currentVersion=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version|grep -Ev '(^\[|Download\w+:)'`
versionwithoutSnap=`echo $currentVersion | cut -d '-' -f1`
#majorVersion=`echo $versionwithoutSnap | cut -d '.' -f1`
#minorVersion=`echo $versionwithoutSnap | cut -d '.' -f2`
#let nextminorVersion=$minorVersion+1
#nextVersion=`echo $majorVersion"."$nextminorVersion`
mvn versions:set -DnewVersion=$versionwithoutSnap versions:commit
echo "The version is bumped to next release version $versionwithoutSnap"

