PWD_DIR="$(pwd)"
sudo k0sctl kubeconfig --config ./k0sctl.yaml > "$PWD_DIR/kube.config"
mkdir -p ~/.kube
sudo ln -sf "$PWD_DIR/kube.config" ~/.kube/kube.config
export KUBECONFIG=~/.kube/kube.config

