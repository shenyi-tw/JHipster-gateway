for p in $(kubectl get pods -o name); do
  kubectl logs $p --all-containers > "$(echo $p | sed 's|pod/||').log"
done