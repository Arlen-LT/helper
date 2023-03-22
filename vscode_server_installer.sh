#!/bin/bash -e

usage(){
    echo "Usage: vscode_server_installer [options]"
    echo "--version"
    echo "--commit[=]<commit_hash>  install vscode server of specified commit hash"
    exit 0
}

install(){
    commit_hash=$1
    rm -rf ~/.vscode-server/bin/${commit_hash} && mkdir -p ~/.vscode-server/bin/${commit_hash}
    wget -O /tmp/vscode-server-stable-linux-x64.tar.gz https://vscode.cdn.azure.cn/stable/${commit_hash}/vscode-server-linux-x64.tar.gz \
		&& tar -xzf /tmp/vscode-server-stable-linux-x64.tar.gz -C ~/.vscode-server/bin/${commit_hash} --strip-components 1
}

version=v0.0.1
options=$(getopt -n "Installing VS Code Server" -l "help,version,commit:" -o "h" -a -- "$@")
eval set -- ${options}
while true
do
    case "$1" in
    	--commit) shift; install $1 ;;
    	-h | --help) usage ;;
    	--version) echo "vscode-server-installer $version by https://github.com/Arlen-LT/utility"; exit 0 ;;
    	--) shift; break;;
    esac
    shift
done
