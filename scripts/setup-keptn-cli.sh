#Start a k3d clusterclear
k3d cluster create mykeptn -p "8082:80@loadbalancer" --k3s-server-arg "--kube-proxy-arg=conntrack-max-per-core=0"  --k3s-agent-arg "--kube-proxy-arg=conntrack-max-per-core=0" --agents 1

#Download and install Keptn CLI
curl -sL https://get.keptn.sh | bash

#Install control-plane and execution-plane for continuous delivery use case using Helm.
helm install keptn https://github.com/keptn/keptn/releases/download/0.14.1/keptn-0.14.1.tgz -n keptn --create-namespace --set=continuous-delivery.enabled=true --wait
helm install helm-service https://github.com/keptn/keptn/releases/download/0.14.1/helm-service-0.14.1.tgz -n keptn --create-namespace --wait
helm install jmeter-service https://github.com/keptn/keptn/releases/download/0.14.1/jmeter-service-0.14.1.tgz -n keptn --create-namespace --wait

# Configure ingress and authenticate Keptn CLI.
curl -SL https://raw.githubusercontent.com/keptn/examples/master/quickstart/expose-keptn.sh | bash