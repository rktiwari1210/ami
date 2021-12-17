#!groovy

def buildBadge
def dateBuildBadge
def amiidBuildBadge

def boolean hasChanged(String searchText) {
// Check if the supplied search text, be it a file name or folder
// name, exists in the list of changed files since the last commit
return sh(
returnStatus: true,
script: "git diff --name-only ${GIT_PREVIOUS_COMMIT} ${GIT_COMMIT} | grep \"${searchText}\""
) == 0
}

// **************************************************************
// Globals
// **************************************************************
// Define global variables with defaults, some of which are set later
// using data retrieved from the (GUI) Configuration Database. The variable
// setting must run after the branch specific configuration file has
// been copied

static String AbortStatus = 'ABORTED'

// These variables should only be set to no for specific testing purposes
// not running this stage will lead to stages downstream failing
static String ExecuteStepGetChangeVersion = "yes"
static String ExecuteStepGitTagVersion = "yes"
static String ExecuteStepSetupBadges = "yes"
static String ExecuteStepBuildInfo = "yes"
static String ExecuteStepValidate = "yes"
static String ExecuteStepBuildAMI = "yes"
static String ExecuteStepRetrieveAMI = "yes"

/* ---------------------------------------------------------- */

pipeline {
	/* insert Declarative Pipeline here */

    agent any

	//this might slow us down but there is a chance one build could be tearing down resources another is using so we'll disable for now.
	options { 
        
        disableConcurrentBuilds() 
        buildDiscarder(
            logRotator(
                // number of build logs to keep
                numToKeepStr:'-1',
                // history to keep in days
                daysToKeepStr: '180',
                // artifacts are kept for days
                artifactDaysToKeepStr: '180',
                // number of builds have their artifacts kept
                artifactNumToKeepStr: '-1'
            )
        )
    }

	environment {

		AMI_NAME = "iac-ventura-gold-ami-${BUILD_NUMBER}"
		PACKER_JSON = "pbps-ami-ventura.json"
		PACKER_DIR = "./"
		AWS_REGION = "us-east-1"
		output = "json"
        DOCKER_REGISTRY='https://docker.dxc.com'
        DOCKER_CREDENTIAL='cis-r'
	}

    parameters { string(name: 'AMI_NAME', defaultValue: 'env.${AMI_NAME}', description: '') }

    stages {

        stage('DEVSECOPS') {

            when { anyOf { branch 'develop'; branch 'release'; branch 'master' } }

            parallel {

                stage('Truffles') {

                    agent {
                        docker {
                            image "docker.dxc.com/bpscloudops-docker/jenkins:alpine-trufflehog-v1"
                            registryUrl env.DOCKER_REGISTRY
                            registryCredentialsId env.DOCKER_CREDENTIAL
                            reuseNode true
                        }
                    }

                    steps {

                        script {

                            def gitInfo = GIT_URL.replaceAll('https://', '')
                            withCredentials([
                                usernamePassword(credentialsId: 'githubapp-bpscloudops', usernameVariable: 'GITHUB_APP', passwordVariable: 'GITHUB_JWT_TOKEN')]) 
                                {
                                sh (
                                    script: "echo START TruffleHog against ${gitInfo}; trufflehog https://${GITHUB_APP}:${GITHUB_JWT_TOKEN}@${gitInfo}",
                                    label: "truffle hunt"
                                )
                            } // withCredentials
                        } // script
                    } // steps

                } // stage

                stage('Scan') {
                    steps {
                        script {
                            sh "echo DEVSECOPS"
                        }
                    }
                } // Stage

            } // Parallel

        }

        stage('CHANGELOG') {

            when {
                not { branch 'PR-*' }
                anyOf { branch 'develop'; branch 'release'; branch 'master' } 
            }

            steps {
                script {
                    def CancelPipeline = 'no'

                    // Pipeline is enabled, so check that actual code has changed, for example, we don't
                    // want to trigger pipelines if it was just a documentation change. Make sure to trigger
                    // when the GUI files have changed
                    // if (hasChanged('CHANGELOG.md') == false && hasChanged('Terraform') == false && hasChanged('Jenkins') == false && hasChanged('GUI/ConfigFiles/environments') == false)
                    if (hasChanged('CHANGELOG.md') == false)
                    {
                        // There have been no changes to CHANGELOG.md 
                        // therefore cancelling build
                        echo 'ABORT this build as CHANGELOG not updated.'
                        CancelPipeline = 'yes'
                        AbortStatus = 'ABORT-CODE'
                        NotificationMessage = "CHANGELOG.md-not-updated."
                        echo 'Aborting Pipeline early as run conditions not met.'
                        currentBuild.result = 'ABORTED'

                        ExecuteStepGetChangeVersion = "no"
                        ExecuteStepGetGitTagVersion = "no"
                        ExecuteStepSetupBadges = "no"
                        ExecuteStepBuildInfo = "no"
                        ExecuteStepValidate = "no"
                        ExecuteStepBuildAMI = "no"
                        ExecuteStepRetrieveAMI = "no"

                        return
                    } // if
                } // script
            } // steps
        } // stage

        stage('VERSION') {

            when {
                expression {
                    return ExecuteStepGetChangeVersion == 'yes';
                }
            }

            steps {
                script {
                    // See https://github.dxc.com/Platform-DXC/automation-bigfix/blob/master/Jenkinsfile
                    echo "Processing the CHANGELOG.md"
                    nextVer = sh (
                                script: 'grep \'^## [[0-9]*.[0-9]*.[0-9]*]$\' CHANGELOG.md | sed -e \'s/^.*\\[//\' -e \'s/\\]//\' |head -1',
                                returnStdout: true
                            ).trim()
                    if (nextVer?.trim()) {
                        NEXTVER = nextVer
                        echo "Next Version:  ${NEXTVER}"
                        env.AMI_NAME2 = "iac-ventura-gold-ami-${NEXTVER}.${BUILD_NUMBER}"
                        echo "AMI NAME = ${AMI_NAME2}"
                        env.PACKAGE_VERSION = "${NEXTVER}.${BUILD_NUMBER}"
                    }else {
                        currentBuild.result = "FAILURE"
                        throw new Exception("Get the Package Version from the CHANGELOG.md failed")
                    }

                } // script
            } // steps
        } // stage

        stage('BADGES') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            }

            when { 
                expression { return ExecuteStepSetupBadges == 'yes'; }
            }
            
            steps {

                script {

                    dateBuildBadge = addEmbeddableBadgeConfiguration(id: "date", subject: "created")
                    def timejobcompleted = sh (script: 'date -u "+%F %H:%M"', returnStdout: true).trim()
                    dateBuildBadge.setStatus(timejobcompleted + " UTC")

                    buildBadge = addEmbeddableBadgeConfiguration(id: "build", subject: "ami name")
                    buildBadge.setColor('grey')
                    buildBadge.setStatus(env.AMI_NAME2)
                    amiidBuildBadge = addEmbeddableBadgeConfiguration(id: "amiid", subject: "ami id")
                    amiidBuildBadge.setColor('lightgrey')
                    
                    def changeLogSets = currentBuild.changeSets
                    for (int i = 0; i < changeLogSets.size(); i++) {
                        def entries = changeLogSets[i].items
                        for (int j = 0; j < entries.length; j++) {
                            def entry = entries[j]
                            echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
                            def files = new ArrayList(entry.affectedFiles)
                            for (int k = 0; k < files.size(); k++) {
                                def file = files[k]
                                echo "  ${file.editType.name} ${file.path}"
                            }
                        }
                    }

                } // script

                script {
                    // See https://github.dxc.com/Platform-DXC/automation-bigfix/blob/master/Jenkinsfile
                   echo "Processing the CHANGELOG.md"
                   nextVer = sh (
                             script: 'grep \'^## [[0-9]*.[0-9]*.[0-9]*]$\' CHANGELOG.md | sed -e \'s/^.*\\[//\' -e \'s/\\]//\' |head -1',
                             returnStdout: true
                           ).trim()
                   if (nextVer?.trim()) {
                       PACKAGE_VERSION = nextVer
                       echo "Next Version:  ${PACKAGE_VERSION}"
                   }else {
                       currentBuild.result = "FAILURE"
                       throw new Exception("Get the Package Version from the CHANGELOG.md failed")
                   }
                } // script

            } // steps

        } // stage

        stage ('GIT TAG') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            } 

            when {
                expression { return ExecuteStepGitTagVersion == 'yes'; }
                not { branch 'PR-*' }
                anyOf {
					changeRequest target: 'master'
					branch 'master'
				}
            }

            steps {
                
                script {

                    env.GIT_ORIGIN_COMMIT = sh (
                            script: 'git rev-parse refs/remotes/origin/${GIT_BRANCH}',
                            returnStdout: true
                        ).trim()

                    withCredentials([
                        usernamePassword(credentialsId: 'githubapp-bpscloudops', usernameVariable: 'GITHUB_APP', passwordVariable: 'GITHUB_JWT_TOKEN')]) 
                        {
                        sh '''
                            echo $GIT_URL
                            gitUrlWithCreds="$(echo "${GIT_URL}" | sed -e 's!://!://'${GITHUB_APP}:${GITHUB_JWT_TOKEN}'@!')"
                            git tag "${PACKAGE_VERSION}" "${GIT_ORIGIN_COMMIT}"
                            git push "${gitUrlWithCreds}" "${PACKAGE_VERSION}"
                        '''
                    } // withCredentials
                }
            }
        } // stage

		stage('INFO') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            }  

            when {
                expression { return ExecuteStepBuildInfo == 'yes'; }
                not { branch 'PR-*' }
            }

			steps {
                withCredentials([
                    string(credentialsId: "LSC2DEV_ARN_TERRAFORMROLE",        variable: 'ARN'),
                    string(credentialsId: "LSC2DEV_EXTID_TERRAFORMROLE",      variable: 'EXTID')
                ])
                {
                    withAWS(role:"${ARN}", externalId: "${EXTID}", region: "${AWS_REGION}") 
                    {
                        dir ("${WORKSPACE}") {
                            sh '''
                                #!/bin/bash
                                set -x;
                                echo 'Packing..'
                                cd ${PACKER_DIR}
                                echo ${BUILD_NUMBER}
                                echo "inspecting.."
                                packer.io inspect ${PACKER_JSON}
                            '''
                        } // dir
			        } // withAWS
                } // withCredentials
            } // steps
		} // stage

		stage('VALIDATE') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            } 

            when {
                expression { return ExecuteStepValidate == 'yes'; }
                not { branch 'PR-*' }
            }

            steps {
                withCredentials([
                    string(credentialsId: "LSC2DEV_ARN_TERRAFORMROLE",        variable: 'ARN'),
                    string(credentialsId: "LSC2DEV_EXTID_TERRAFORMROLE",      variable: 'EXTID')
                ])
                {
                    withAWS(role:"${ARN}", externalId: "${EXTID}", region: "${AWS_REGION}") 
                    {
                        dir ("${WORKSPACE}") {
                            sh '''
                            #!/bin/bash
                            set -x;
                            env
                            pip freeze
                            cd ${PACKER_DIR}
                            echo "validating.."   
                            export WINRM_PASS AMI_NAME2
                            echo "AMI_NAME2="${AMI_NAME2}
                            packer.io validate \
                                -var 'aws_region=${env.AWS_REGION}' \
                                -var 'dest_ami_name=${env.AMI_NAME2}' \
                                -var 'git_commit=${env.GIT_ORIGIN_COMMIT}' \
                                ${PACKER_JSON}
                            '''
                            } // dir
                        } // withAWS
                } // withcredentials

            } // steps
        } // End of validation stage 

		stage('BUILD') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            } 

            when {
                expression { return ExecuteStepBuildAMI == 'yes'; }
                not { branch 'PR-*' }
                anyOf {
                    changeRequest target: 'master'
                    branch 'master'
                }
            }

            steps {

                script {
                    withCredentials([string(credentialsId:'TEAMS_WEBHOOK',variable:'TEAMS_WEBHOOK')]) {
                        office365ConnectorSend (
                            message: "Starting Build of Ventura AMI: ${AMI_NAME2}", 
                            status:"Started", 
                            webhookUrl:"$TEAMS_WEBHOOK"
                        )
                    }                    
                } // script

                withCredentials([
                    string(credentialsId: "LSC2DEV_ARN_TERRAFORMROLE",        variable: 'ARN'),
                    string(credentialsId: "LSC2DEV_EXTID_TERRAFORMROLE",      variable: 'EXTID'),
                    usernamePassword(credentialsId: 'cis-dev-winrm-admin', usernameVariable: 'WINRM_USER', passwordVariable: 'WINRM_PASS')]) {
                    withAWS(role:"${ARN}", externalId: "${EXTID}", region: "${AWS_REGION}") {
                        dir ("${WORKSPACE}") {
                            sh '''
                                CWP_VERSION=$(cat ./cfg/cwp_version.txt)
                                SESSIONID="${AMI_NAME2}_$(date +"%s")"
                                set +x
                                aws sts assume-role --role-arn "${ARN}" --role-session-name ${SESSIONID} > assume-role-output.txt
                                export AWS_ACCESS_KEY_ID=`cat assume-role-output.txt | jq -c '.Credentials.AccessKeyId' | tr -d '"' | tr -d ' '`
                                export AWS_SECRET_ACCESS_KEY=`cat assume-role-output.txt | jq -c '.Credentials.SecretAccessKey' | tr -d '"' | tr -d ' '`
                                export AWS_SESSION_TOKEN=`cat assume-role-output.txt | jq -c '.Credentials.SessionToken' | tr -d '"' | tr -d ' '`
                                rm assume-role-output.txt
                                set -x
                                cd ${PACKER_DIR}
                                export WINRM_PASS AMI_NAME2 CWP_VERSION AWS_REGION
                                export PACKER_LOG=1
                                echo "building.."
                                packer.io build \
                                    -var 'dest_ami_name=${env.AMI_NAME2}' \
                                    -var 'git_commit=${env.GIT_ORIGIN_COMMIT}' \
                                    -var 'CWP_VERSION=${env.CWP_VERSION}' \
                                    ${PACKER_JSON}
                            ''' 
                        } // dir 
                    } // withAWS
                } // withCredentials
            } // steps

            post {

                success {
                    script {
                        withCredentials([string(credentialsId:'TEAMS_WEBHOOK',variable:'TEAMS_WEBHOOK')]) {
                            office365ConnectorSend (
                                webhookUrl:"$TEAMS_WEBHOOK",
                                message: "$AMI_NAME2 has been created",
                                status: 'Success',
                                color: '#0000FF'
                            )
                        }
                    }
                }
            } 

		} // End of build stage

		stage('AMI') {

            agent {
                docker {
                    image "docker.dxc.com/bpscloudops-docker/packer:latest"
                    registryUrl env.DOCKER_REGISTRY
                    registryCredentialsId env.DOCKER_CREDENTIAL
                    reuseNode true
                }
            } 

            when {
                expression { return ExecuteStepRetrieveAMI == 'yes' }
                not { branch 'PR-*' }
                anyOf {
					changeRequest target: 'master'
					branch 'master'
				}
            }

			steps {
                
				script {
                    withCredentials([
                    string(credentialsId: "LSC2DEV_ARN_TERRAFORMROLE",        variable: 'ARN'),
                    string(credentialsId: "LSC2DEV_EXTID_TERRAFORMROLE",      variable: 'EXTID')]) 
                    {
                        withAWS(role:"${ARN}", externalId: "${EXTID}", region: "${AWS_REGION}") {
                                    env.AMI_ID = sh(
                                        script: '''
                                        #!/bin/bash
                                        set +x
                                        export ARN EXTID AWS_REGION
                                        aws ec2 describe-images --filters Name=tag:Name,Values=${AMI_NAME2} --query 'Images[*].ImageId' --output text
                                        ''',
                                        returnStdout: true
                                    ).trim()
                            
                            script {
                                amiidBuildBadge.setStatus(env.AMI_ID)
                            }

                            echo "${env.AMI_ID}"
                            echo "${env.AMI_NAME2}"

                        } // withAWS

                    } //withCredentials

				} // script
                
			} // steps

		} // stage

    } // stages

} // pipeline