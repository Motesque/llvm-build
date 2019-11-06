/*
Jenkinsfile
-----------
scopethemove

*/

pipeline {
    agent { label 'fra1-jenkins-02.motesque.com' }
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('Build-amd64') {
            steps {
                sh 'automation/jenkins_build.sh amd64'
                archiveArtifacts 'artifacts/*.tar.gz'
                sshPublisher(publishers: [sshPublisherDesc(configName: 'nyc3-download-01.motesque.com/packages', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: 'artifacts/', sourceFiles: 'artifacts/*.tar.gz')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])

            }
        }
        stage('Build-raspberrypi3') {
            steps {
                sh 'automation/jenkins_build.sh raspberrypi3'
                archiveArtifacts 'artifacts/*.tar.gz'
                sshPublisher(publishers: [sshPublisherDesc(configName: 'nyc3-download-01.motesque.com/packages', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: 'artifacts/', sourceFiles: 'artifacts/*.tar.gz')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('Build-imx8m-var-dart') {
            steps {
                sh 'automation/jenkins_build.sh imx8m-var-dart'
                archiveArtifacts 'artifacts/*.tar.gz'
                sshPublisher(publishers: [sshPublisherDesc(configName: 'nyc3-download-01.motesque.com/packages', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: 'artifacts/', sourceFiles: 'artifacts/*.tar.gz')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }

    }
}
