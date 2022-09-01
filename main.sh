#!/bin/bash
#interface for checking pre-requisites
echo "There are 4 pre-requisites to install before installing Keptn: "
echo "1. Docker"
echo "2. Kubectl"
echo "3. Helm" 
echo "4. Git"
echo "Checking Docker..."
sudo docker -v
docker_present=$?
echo "Checking Kubectl..."
kubectl
kubectl_present=$?
echo "Checking helm..."
helm version
helm_present=$?
echo "Checking git..."
git --version
git_present=$?

if [ $docker_present != 0 ];then
    echo "Docker is not installed"
    echo "Install docker using this link https://docs.docker.com/engine/install/"
fi

if [ $kubectl_present != 0 ];then
    echo "Kubectl is not installed"
    echo "Kubectl docker using this link https://kubernetes.io/docs/tasks/tools/"
fi

if [ $helm_present != 0 ];then
    echo "Helm is not installed"
    echo "Install Helm using this link https://helm.sh/docs/intro/install/"
fi

if [ $git_present != 0 ];then
    echo "Git is not installed"
    echo "Install Git using this link https://github.com/git-guides/install-git"
fi

if  [[ ( $docker_present == 0 ) && ( $kubectl_present == 0 ) && ( $helm_present == 0 ) && ( $git_present == 0 ) ]];then
    echo
    echo "Installing k3d..."
    bash scripts/install-k3d.sh

    echo "Installing and Setting up Keptn ... "
    bash scripts/setup-keptn-cli.sh
fi