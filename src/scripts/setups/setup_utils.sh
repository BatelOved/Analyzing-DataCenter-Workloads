#!bin/bash

reset="\033[0m"
purple="\033[35m"
green="\033[32m"

PROJECT_NAME="Analyzing-DataCenter-Workloads"


##################################################################################################
#                                          Setup Utilities                                       #
##################################################################################################

function setup_echo() {
    echo -e "\\n${purple}${PROJECT_NAME}: $1 Installation...\\n${reset}"
}

function setup_pkgExists() {
    echo $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed")
}

function setup_ohMyBash() {
    echo $(setup_echo "Oh-My-Bash")
    (bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)") &
}

function setup_gitAlias() {
    echo $(setup_echo "Git Aliases")

    git config --global alias.br "branch"
    git config --global alias.st "status"
    git config --global alias.ci "commit"
    git config --global alias.co "checkout"
    git config --global alias.c-p "cherry-pick"
    git config --global alias.logg "log --all --decorate --graph --oneline"
}

function setup_pythonEnv() {
    echo $(setup_echo "Python Env")
    sudo apt-get update && sudo apt-get install -y python3-venv
    /usr/bin/python3 -m venv $HOME/my_virtualenv
    pip install --upgrade pip
    source $HOME/my_virtualenv/bin/activate
    export CLOUDSDK_PYTHON=$HOME/my_virtualenv/bin/python
}

function setup_envVar() {
    echo $(setup_echo "setup_env.sh")
    source $HOME/Analyzing-DataCenter-Workloads/src/scripts/setups/setup_env.sh
}

function setup_arch() {
    if [ "$1" == "intel" ]; then
        arch="intel"
    elif [ "$1" == "arm" ]; then
        arch="arm"
    else
        arch="intel"
    fi

    export ARCH=$arch

    echo -e "\\n${green}${PROJECT_NAME}: Architecture set to $arch\\n${reset}"
}

function setup_compiler() {
    local compilers=""

    if [ "$1" == "y" ]; then
        ## Download gcc
        sudo apt-get install -y make gcc numactl

        compilers+="gcc "
    fi
    if [ "$2" == "y" ]; then
        ## Download clang
        sudo apt-get install -y clang llvm lld

        compilers+="clang "
    fi
    if [ "$3" == "y" ]; then
        ## Download icx
        # download the key to system keyring
        wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
        | gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null

        # add signed entry to apt sources and configure the APT client to use Intel repository:
        echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

        sudo apt-get update && sudo apt-get install -y intel-basekit

        source /opt/intel/oneapi/setvars.sh

        compilers+="icx "
    fi

    echo -e "\\n${green}${PROJECT_NAME}: Download compilers are - $compilers\\n${reset}"
}

function setup_general_install() {
    setup_arch $1
    setup_compiler $2 $3 $4
    setup_ohMyBash
    setup_gitAlias
    setup_pythonEnv
    setup_envVar
}

##################################################################################################
#                                        Benchmarks Utilities                                    #
##################################################################################################

function setup_pkb() {
    echo $(setup_echo "PerfKitBenchmarker Requirements")

    pip3 install -r $HOME/Analyzing-DataCenter-Workloads/PerfKitBenchmarker/requirements.txt
    pip3 install -r $HOME/Analyzing-DataCenter-Workloads/PerfKitBenchmarker/perfkitbenchmarker/providers/aws/requirements.txt
}

function setup_multichase() {
    echo $(setup_echo "Multichase Requirements")

    if [ $(setup_pkgExists gcc) -eq 0 ]; then
        sudo apt-get install -y make gcc numactl
    fi
}

function setup_fleetbench() {
    echo $(setup_echo "Fleetbench Requirements")

    if [ $(setup_pkgExists bazel) -eq 0 ]; then
        if [ "$ARCH" == "intel" ]; then
            curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
            sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
            sudo apt-get update && sudo apt-get install -y bazel
        elif [ "$ARCH" == "arm" ]; then
            BAZEL_LATEST_VERSION=$(curl -s https://api.github.com/repos/bazelbuild/bazel/releases/latest | grep tag_name | cut -d '"' -f 4)
            wget https://github.com/bazelbuild/bazel/releases/download/$BAZEL_LATEST_VERSION/bazel-$BAZEL_LATEST_VERSION-linux-arm64
            chmod +x bazel-$BAZEL_LATEST_VERSION-linux-arm64
            sudo mv bazel-$BAZEL_LATEST_VERSION-linux-arm64 /usr/local/bin/bazel
        fi
    fi

    if [ $(setup_pkgExists g++) -eq 0 ]; then
        sudo apt-get install g++
    fi

    if [ $(setup_pkgExists libpfm4) -eq 0 ]; then
        sudo apt-get install libpfm4-dev
    fi
}

function setup_stream() {
    echo $(setup_echo "Stream Requirements")

    source /opt/intel/oneapi/setvars.sh
}
