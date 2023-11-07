#!/bin/bash


PROJECT_NAME="Analyzing-DataCenter-Workloads"

# Reset color and style
reset="\033[0m"

# Foreground colors
black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"

echo -e "\n${purple}${PROJECT_NAME}: Setup Start\n${reset}"

# Oh-My-Bash:
echo -e "\n${purple}${PROJECT_NAME}: Oh-My-Bash Installation...\n${reset}"
(bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)") &

# Git Configurations:
echo -e "\n${purple}${PROJECT_NAME}: Git Configurations Installation...\n${reset}"
git config --global alias.br "branch"
git config --global alias.st "status"
git config --global alias.ci "commit"
git config --global alias.co "checkout"
git config --global alias.c-p "cherry-pick"
git config --global alias.logg "log --all --decorate --graph --oneline"

# Python Env & pip:
echo -e "\n${purple}${PROJECT_NAME}: Python Env & pip Installation...\n${reset}"
sudo apt-get update && sudo apt-get install -y python3-venv
/usr/bin/python3 -m venv $HOME/my_virtualenv
pip install --upgrade pip

echo -e "\n${purple}${PROJECT_NAME}: Running setup_env.sh...\n${reset}"
source $HOME/Analyzing-DataCenter-Workloads/src/scripts/setups/setup_env.sh

sudo apt-get install -y apt-transport-https curl gnupg

# PerfKitBenchmarker Requirements:
echo -e "\n${purple}${PROJECT_NAME}: PerfKitBenchmarker Requirements Installation...\n${reset}"
pip3 install -r $HOME/Analyzing-DataCenter-Workloads/PerfKitBenchmarker/requirements.txt

# PerfKitBenchmarker on AWS Requirements:
echo -e "\n${purple}${PROJECT_NAME}: PerfKitBenchmarker on AWS Requirements Installation...\n${reset}"
pip3 install -r $HOME/Analyzing-DataCenter-Workloads/PerfKitBenchmarker/perfkitbenchmarker/providers/aws/requirements.txt

# Multichase Utilities:
echo -e "\n${purple}${PROJECT_NAME}: Multichase Utilities Installation...\n${reset}"
sudo apt-get install -y make gcc numactl

# Fleetbench Utilities:
echo -e "\n${purple}${PROJECT_NAME}: Fleetbench Utilities Installation...\n${reset}"
# Clang compiler download -
# sudo apt-get install -y clang llvm lld

# Intel icc compiler download -
# download the key to system keyring
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null

# add signed entry to apt sources and configure the APT client to use Intel repository:
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

sudo apt-get update && sudo apt-get install -y intel-basekit

# Bazel Intel download -
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt-get update && sudo apt-get install -y bazel

# Bazel ARM download -
# BAZEL_LATEST_VERSION=$(curl -s https://api.github.com/repos/bazelbuild/bazel/releases/latest | grep tag_name | cut -d '"' -f 4)
# wget https://github.com/bazelbuild/bazel/releases/download/$BAZEL_LATEST_VERSION/bazel-$BAZEL_LATEST_VERSION-linux-arm64
# chmod +x bazel-$BAZEL_LATEST_VERSION-linux-arm64
# sudo mv bazel-$BAZEL_LATEST_VERSION-linux-arm64 /usr/local/bin/bazel


echo -e "\n${purple}${PROJECT_NAME}: Setup End\n${reset}"
