Vagrant.configure("2") do |config|

  # ---------------------------------------------------------
  # Ubuntu base box
  # ---------------------------------------------------------
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "nested-vagrant"

  # Keep Vagrant's default SSH key
  config.ssh.insert_key = false

  # ---------------------------------------------------------
  # Network
  # ---------------------------------------------------------
  # Default NAT networking is enough for the outer VM.
  # Vagrant will use SSH port forwarding automatically.
  #
  # 127.0.0.1:2222 -> outer VM:22
  #

  # ---------------------------------------------------------
  # VirtualBox configuration
  # ---------------------------------------------------------
  config.vm.provider "virtualbox" do |vb|

    vb.name = "nested-vagrant"

    # 10 GB RAM
    vb.memory = 10240

    # 8 CPU cores
    vb.cpus = 8

    # Enable nested virtualization
    vb.customize [
      "modifyvm",
      :id,
      "--nested-hw-virt",
      "on"
    ]

    # Video memory
    vb.customize [
      "modifyvm",
      :id,
      "--vram",
      "128"
    ]

  end

  # ---------------------------------------------------------
  # Provision the outer VM
  # ---------------------------------------------------------
  config.vm.provision "shell", inline: <<-SHELL

    set -e

    echo "=========================================="
    echo " Updating Ubuntu"
    echo "=========================================="

    apt-get update

    echo "=========================================="
    echo " Installing required packages"
    echo "=========================================="

    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      virtualbox \
      build-essential \
      dkms \
      linux-headers-$(uname -r) \
      curl \
      wget \
      git \
      net-tools \
      openssh-client \
      gnupg \
      lsb-release \
      ca-certificates

    echo "=========================================="
    echo " Installing Vagrant"
    echo "=========================================="

    # HashiCorp repository
    wget -O- https://apt.releases.hashicorp.com/gpg \
      | gpg --dearmor \
      | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      | tee /etc/apt/sources.list.d/hashicorp.list

    apt-get update

    DEBIAN_FRONTEND=noninteractive apt-get install -y vagrant

    echo "=========================================="
    echo " Checking CPU virtualization"
    echo "=========================================="

    if grep -E -q 'vmx|svm' /proc/cpuinfo; then
      echo "SUCCESS: CPU virtualization extensions are visible."
      grep -E -o 'vmx|svm' /proc/cpuinfo | sort -u
    else
      echo "WARNING: CPU virtualization extensions are NOT visible."
      echo "Nested virtualization may not be working."
    fi

    echo "=========================================="
    echo " VirtualBox version"
    echo "=========================================="

    VBoxManage --version

    echo "=========================================="
    echo " Vagrant version"
    echo "=========================================="

    vagrant --version

    echo "=========================================="
    echo " Hardware"
    echo "=========================================="

    echo "CPU cores:"
    nproc

    echo "Memory:"
    free -h

    echo "=========================================="
    echo " Outer VM setup complete"
    echo "=========================================="

  SHELL

end

