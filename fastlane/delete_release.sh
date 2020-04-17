## errors if release doesn't exist
echo "${VERSION_DEPLOY}"

git tag -d ${VERSION_DEPLOY}
git push "https://$NAME_REPO_TOKEN:$REPO_TOKEN@github.com/ZupIT/beagle-closed.git" :${VERSION_DEPLOY}
