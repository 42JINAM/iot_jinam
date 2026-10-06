set +e

cd "$(mktemp -d)"
KUBIE_VERSION=v0.26.1
KUBIE_SHA256=e10ab6b929adf805deac47aecd6d316202f3bb729b5bbeb66e62f0bdb394fb2c


sudo mkdir -p $KUBE_HOME/.kube

curl -sSLf -O \
  "https://github.com/kubie-org/kubie/releases/download/${KUBIE_VERSION}/kubie-linux-arm64"
echo "${KUBIE_SHA256}  kubie-linux-arm64" | sha256sum --check
sudo install -m 0755 kubie-linux-arm64 /usr/local/bin/kubie
kubie --version



echo "Successfully installed kubie"

echo "alias kns='kubie ns'" >> /home/vagrant/.bashrc
echo "alias kx='kubie ctx'" >> /home/vagrant/.bashrc