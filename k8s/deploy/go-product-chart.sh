export CHART_NAME=go-product-chart
kubectl delete -f ../$CHART_NAME/$CHART_NAME.yaml

if [[ "$1" == "1" ]]; then
    echo "Rebuilding Docker image..."

  my_folder=$(pwd)
  cd /Volumes/CT1-data/git/shen/golang/server/go-consul-crud && sh docker_build.sh
  cd $my_folder

  minikube ssh "docker rmi go-consul-crud:latest || true"
  minikube image load go-consul-crud:latest
  minikube ssh "docker images go-consul-crud:latest"
fi

kubectl apply -f ../$CHART_NAME/$CHART_NAME.yaml

