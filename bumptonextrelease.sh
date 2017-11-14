#!/bin/bash
currentVersion=`mvn -f complete/pom.xml org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version|grep -Ev '(^\[|Download\w+:)'`
versionwithoutSnap=`echo $currentVersion | cut -d '-' -f1`
newbranch=$versionwithoutSnap-tag
git branch $newbranch
git checkout $newbranch
mvn -f complete/pom.xml versions:set -DnewVersion=$versionwithoutSnap versions:commit
echo "The version is bumped to next release version $versionwithoutSnap"
echo `mvn -f complete/pom.xml org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version|grep -Ev '(^\[|Download\w+:)'` > version.txt
#echo `ls complete/target/*.jar` > jarpath.txt

