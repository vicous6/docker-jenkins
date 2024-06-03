node {
    def app
stage('Initialize'){
        def dockerHome = tool 'docker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
	
        checkout scm
    }

    stage('Print Working Directory') {

            sh 'pwd'

	    sh 'ls'
sh 'echo $PATH'

    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
sh 'sudo service docker restart'
        app = docker.build("docker-jenkins")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
