wget https://github.com/github/hub/releases/download/v2.7.1/hub-linux-amd64-2.7.1.tgz
tar zvxvf hub-linux-amd64-2.7.1.tgz
sudo ./hub-linux-amd64-2.7.1/install
# Setup autocomplete for bash:
mkdir -p ~/.bash/completions
mv ./hub-linux-amd64-2.7.1/etc/hub.bash_completion.sh ~/.bash/completions/_hub
echo "if [ -f ~/.bash/completions/_hub ]; then" >> ~/.bashrc
echo "    . ~/.bash/completions/_hub" >> ~/.bashrc
echo "fi" >> ~/.bashrc
# add alias
echo "eval "$(hub alias -s)"" >> ~/.bashrc
# Cleanup
rm -rf hub-linux-amd64-2.7.1
hub version
set -e
# Authorize hub
mkdir -p ~/.config/
cat << EOF > ~/.config/hub
github.com:
  - user: "$NAME_REPO_TOKEN"
    oauth_token: "$REPO_TOKEN"
    protocol: https
EOF
set +e
##cd $PROJECT_LOCATION
pwd
## errors if release doesn't exist
gitBranch=$(git branch | sed -n '/^\* /s///p')

echo "$gitBranch"

hub release delete ${gitBranch}