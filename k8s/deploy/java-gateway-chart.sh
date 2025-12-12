export CHART_NAME=java-gateway-chart
kubectl delete -f ../$CHART_NAME/$CHART_NAME.yaml


# 判斷參數是否是 rebuild
if [[ "$1" == "1" ]]; then
    echo "Rebuilding Docker image..."

  my_folder=$(pwd)
  # configmap
  cd /Volumes/CT1-data/git/shen/java/jhipster/gateway/src/main/resources/config
  kubectl delete configmap gateway-application

  kubectl create configmap gateway-application \
  --from-file=application.yml \
  --from-file=application-prod.yml \
  --from-file=bootstrap-prod.yml

  kubectl get configmap gateway-application -o yaml

  cd /Volumes/CT1-data/git/shen/java/jhipster/gateway && sh docker_build.sh

  minikube ssh "docker rmi gateway-java-gateway:latest || true"
  minikube image load gateway-java-gateway:latest
  minikube ssh "docker images gateway-java-gateway:latest"

  cd $my_folder

fi

kubectl delete -f ../$CHART_NAME/$CHART_NAME.yaml
kubectl apply -f ../$CHART_NAME/$CHART_NAME.yaml

kubectl exec -it $(kgp | grep $CHART_NAME | awk '{print $1}') -- printenv DB_HOST
# k logs --tail=555 $(kgp | grep java-gateway-chart | awk '{print $1}') -f
