# aoldot

# Basic Procedure #

* Googled "continuous integration github aws"
   * Chose nginx as the web server
   * Jenkins as the CI server
   * AWS as the cloud provider
   * Github as the repository
* Installed "git" on macbook
   * Recovered github account from 2011
   * Cloned aol/devops-test into rjrudi/aoldot
   * Installed "go" distribution onto macbook
   * Built and tested server.go
   * Changed server.go to not exit on errors and to not fetch from an internal AOL IP address
* Signed up and spun up free Ubuntu image on AWS
   * Modified security group to allow TCP on port 80, 8080 and 88888
   * Tested connectivity using nc -l 80, nc -l 8080 and nc -l 8888
   * apt-get install gccgo-go
   * apt-get install nginx
   * apt-get install jenkins failed, google provided the following workaround
      * wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
      * sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
      * sudo apt-get update
      * Then sudo apt-get install jenkins worked
   * Modified nginx to forward port 80 requests to 8080 Jenkins server
* Configured Jenkins on AWS
   * Added github plugin
   * Created aoldot project
   * Referred it to the Github repository, selected build trigger when Github changes
   * sudo jenkins and run ssh-keygen to create a public key
   * Added the key to Github account and tested ssh connectivity from AWS instance to Github
   * Added Jenkins as a webhook in Github
   * Verified that changes made to Github triggered a build in Jenkins
* Build and Deploy scripts in Jenkins
   * Write build.sh to build server.go
   * Write deploy.sh to deploy server 
   * Add build and deply scripts to project
   * Build.sh compiles and starts the server on port 17222 and tests it with curl
   * Deploy.sh starts the server on the official port 8888 and tests it with curl 
