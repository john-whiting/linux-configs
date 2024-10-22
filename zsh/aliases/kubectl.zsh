kubectx() {
  kubectl config use-context $(kubectl config get-contexts -o name | fzy)
}
