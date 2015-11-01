# aoldot

# Summary #
For this exercise I chose to clone aol/devops-test into rjrudi/aoldot on Github. Changes commited to aoldot will cause a build trigger to be posted to Jenkins - a continuous integration server - running on a free Ubuntu instance on AWS. When triggered Jenkins pulls down the latest Github files, then runs custom-made build and deploy scripts. The build script compiles the application; if successful it starts the server on an internal port so as to test it via curl. If that succeeds then the test server is killed and the deploy script is invoked. The deploy script kills any previously running server, and starts the recently built one. It is also tested with curl and if it succeeds, the build is shown in Jenkins console as successful. With this arrangement any Github member should be able to commit changes to server.go and within 1 minute see the changes reflected in production. The scripts are also part of this repository.
# Basics #
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
* End-End Testing
  * Commit a change to the Github project
  * From the Jenkins console note a new build had been schduled and completed
  * If intentional errors introduced into the source, the server on AWS port 8888 should not change
  * If no errors, the server on AWS port 8888 should reflect the changes
  * This was verified
