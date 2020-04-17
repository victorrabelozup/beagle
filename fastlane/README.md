fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### deploy_new_version
```
fastlane deploy_new_version
```
Generate new release

----

## Android
### android ci
```
fastlane android ci
```
Pull Request verification
### android ci_deploy
```
fastlane android ci_deploy
```
Deploy remote new version
### android ci_local_deploy
```
fastlane android ci_local_deploy
```
Deploy local new version

----

## iOS
### ios ci
```
fastlane ios ci
```
Lane for CI

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
