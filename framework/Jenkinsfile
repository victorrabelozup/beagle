node {

  try {
   
    buildDockerBuilder {
            dockerRepositoryName = "darwin-beagle-framework"
            dockerFileLocation = "."
	    dockerFileBuilder = "DockerfileBuilder"
            team = "Realwave"
    }


    mvnBuildWithCompose {
            composeFileName = "docker-compose-ci.yml"
            composeService = "darwin-beagle-framework"
            composeProjectName = "darwin-beagle-framework"
            team = "Realwave"
	    useBuilder="true"
     }

    stage('SonarQube analysis') {
            def scannerHome = tool 'Sonar Zup';
            withSonarQubeEnv('Sonar Zup') {
                sh "${scannerHome}/bin/sonar-scanner"
            }
     }

     sleep 5

     stage("Quality Gate") {
            timeout(time: 1, unit: 'HOURS') {
               def qg = waitForQualityGate()
               if (qg.status != 'OK') {
                   error "Pipeline aborted due to quality gate failure: ${qg.status}"
               }
           }
     }
    
     tagRelease {
     	gitRepo = "github.com/ZupIT/darwin-beagle-framework"
     }
  } catch (e) {
      notifyBuildStatus {
        buildStatus = "FAILED"
      }
      throw e
  }

}
