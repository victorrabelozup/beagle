#!/bin/sh

set -e

mvn -Dmaven.repo.local=/home/maven/.m2/repository -f /home/application/pom.xml clean install -U
