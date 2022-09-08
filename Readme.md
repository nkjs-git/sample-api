
**Pre-Requisites **
- Docker installed on VM (Working on Ubuntu VM)
- Docker hub account with repository 

**References: **

- https://www.edureka.co/community/55640/jenkins-docker-docker-image-jenkins-pipeline-docker-registry


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

    **docker run --name jenkins-docker -p 8082:8080 -v /var/run/docker.sock:/var/run/docker.sock jenkins-docker:latest**

    **Note:** Get the jenkins secrete from container using below command

    **docker container exec f75 sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"**
    
4. Lauch the jenkins in browser and complete the jenkins basic setup with suggested plugins installation and user configuration

5. Go to manage plugins in jenkins page and install **Docker Pipeline plugin** for running docker command in pipeline stages

6. Create a dockerhub credentials in jenkins global credentials (admin->credentials->global credentials -> add credentials). Check reference 1 (edureka) for adding credentials

7. 


