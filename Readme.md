
**Pre-Requisites**
- Docker installed on VM (Working on Ubuntu VM)
- Docker hub account with repository 
- Node.js project in github

**References:**

- https://www.edureka.co/community/55640/jenkins-docker-docker-image-jenkins-pipeline-docker-registry
- https://stackoverflow.com/questions/41215997/jenkins-docker-pipeline-error


**Steps:**

1. Create a Dockerfile in working directory and paste the below script in it ro build a jenkins with docker installed

```
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && \
apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
apt-get update && \
apt-get -y install docker-ce
RUN apt-get install -y docker-ce
RUN usermod -a -G docker jenkins
USER jenkins
```

2. Create the docker image for jenkins container by running the below command

    **docker build -t jenkins-docker .**

3. Create a jenkins container from above created image using below command

    **docker run -d --name jenkins-docker -p 8082:8080 -v /var/run/docker.sock:/var/run/docker.sock jenkins-docker:latest**

    **Note:** Get the jenkins secrete from container using below command

    **docker container exec f75 sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"**
    
4. Lauch the jenkins in browser and complete the jenkins basic setup with suggested plugins installation and user configuration

5. Go to manage plugins in jenkins page and install **Docker Pipeline plugin** for running docker command in pipeline stages

6. Create a dockerhub credentials in jenkins global credentials (admin->credentials->global credentials -> add credentials). Check reference 1 (edureka) for adding credentials


7. Create new pipeline item in jenkins by selecting 'pipeline' as item type and select the pipeline script from SCM and select Jenkinsfile from this repo 

8. Review and click build now.

**Note:** 

**Error 1:** 

```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/build?buildargs=%7B%7D&cachefrom=%5B%5D&cgroupparent=&cpuperiod=0&cpuquota=0&cpusetcpus=&cpusetmems=&cpushares=0&dockerfile=Dockerfile&labels=%7B%7D&memory=0&memswap=0&networkmode=default&rm=1&shmsize=0&t=gustavoapolinario%2Fdocker-test%3A3&target=&ulimits=null&version=1": dial unix /var/run/docker.sock: connect:
```
Solution: If the above error is seen run the command to provide permission to jenkins user for volume file system
- docker exec -u root -it jenkins-docker1 /bin/bash
- chown jenkins /var/run/docker.sock



**Error 2:**

```groovy.lang.MissingPropertyException: No such property: docker for class: groovy.lang.Binding```

- Solution: Download plugin Docker Pipeline in jenkins and restart the container


