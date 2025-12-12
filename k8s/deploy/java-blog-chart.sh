export CHART_NAME=java-blog-chart
kubectl delete -f ../$CHART_NAME/$CHART_NAME.yaml

if [[ "$1" == "1" ]]; then
    echo "Rebuilding Docker image..."

  my_folder=$(pwd)
  cd /Volumes/CT1-data/git/shen/java/security-demo3/blog && sh docker_build.sh
  cd $my_folder

  minikube ssh "docker rmi blog-java-blog:latest || true"
  minikube image load blog-java-blog:latest
  minikube ssh "docker images blog-java-blog:latest"
fi

kubectl apply -f ../$CHART_NAME/$CHART_NAME.yaml

