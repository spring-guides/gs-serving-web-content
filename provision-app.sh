#!/bin/bash
BUILD_NUMBER=$1
docker build -t rajranjan/gs-serving-web-content:v_${BUILD_NUMBER} .
docker login -u rajranjan -p Rajranjan123
docker push rajranjan/gs-serving-web-content:v_${BUILD_NUMBER}
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" my-poc.json > my-poc-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family gs-serving-web-content --cli-input-json file://my-poc-v_${BUILD_NUMBER}.json
TASK_REVISION=`aws ecs describe-task-definition --task-definition gs-serving-web-content | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
RUNNING_TASK_ID=`aws ecs list-tasks --cluster  gs-serving-web-content-cluster --family gs-serving-web-content | egrep arn:aws:ecs | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
aws ecs stop-task --cluster gs-serving-web-content-cluster --reason "To run a new version" --task ${RUNNING_TASK_ID}
aws ecs run-task --cluster gs-serving-web-content-cluster --task-definition gs-serving-web-content:$TASK_REVISION
