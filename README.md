[![Build Status](https://app.bitrise.io/app/ba33132ae93f50c8/status.svg?token=ET78G0IwTjRaVguEnzRPhw&branch=master)](https://app.bitrise.io/app/ba33132ae93f50c8)
[![codecov](https://codecov.io/gh/ZupIT/darwin-beagle-android/branch/master/graph/badge.svg?token=hKpCrqZHxt)](https://codecov.io/gh/ZupIT/darwin-beagle-android)

## Testing
We are using the plugin [Shot](https://github.com/Karumi/Shot/) run snapshots tests.

## Local Development
Here are some useful Gradle/adb commands for executing this example:

 * `./gradlew assembleDebug` - Builds the debug apk.
 * `./gradlew detekt` - Execute the checkstyle task to verify code style.
 * `./gradlew connectedDebugAndroidTest` - Executes the instrumented tests on connected device.
 * `./gradlew jacocoTestReport` - Executes coverage report that can be found on build folder.
 * `./gradlew executeScreenshotTests -Precord` - Executes snapshots recording(must be made using the emulator Nexus5,21,en,portrait) at folder  `"${projectDir}/screenshots/`
 * `./gradlew executeScreenshotTests` - Verifies if the current screens against the previous snapshots at folder  `"${projectDir}/screenshots/` using the current connected device
 * `./gradlew executeScreenshotTests -PrunInstrumentation=false` - Verifies if the current screens against the previous snapshots at folder  `"${projectDir}/screenshots/` without using the current connected device.
 In that case the current screenshots(that may be generated on a remote device) must be copied to the folder `"${projectDir}/screenshots/screenshots-default`
