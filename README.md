[![Build Status](https://app.bitrise.io/app/ba33132ae93f50c8/status.svg?token=ET78G0IwTjRaVguEnzRPhw&branch=master)](https://app.bitrise.io/app/ba33132ae93f50c8)
[![codecov](https://codecov.io/gh/ZupIT/darwin-beagle-android/branch/master/graph/badge.svg?token=hKpCrqZHxt)](https://codecov.io/gh/ZupIT/darwin-beagle-android)


Beagle is a cross-platform framework that allows to apply Server-Driven UI natively in iOS, Android and Web.Then, the layouts can be created in a Backend for Frontend middleware.

## Getting started
#### gradle (gradle 5.4.1)
```javascript
// Add it in your root build.gradle at the end of repositories:
allprojects {
    repositories {
        google()
        jcenter()
        maven {
            credentials {
                // user@password with read only access
                username "beagle"
                password "Xq7wAh3xDkGN"
            }
            url 'https://repo-iti.zup.com.br/repository/beagle-jars-all/'
        }
    }
}
```
```javascript
// Add in your app level dependency
dependencies {
    implementation "br.com.zup.beagle:android:$version"
}
```

```javascript
//This class must be used by the RenderEngine in order to define the styles configured at the application. It must extend DesignSystems.
//These are the styles the AppDesignSystem implements: buttonStyle, toolbarStyle, textAppearance, theme and image

class AppDesignSystem(
    private val context: Application
) : DesignSystem {
    override fun toolbarStyle(name: String): Int {
    }

    override fun buttonStyle(name: String): Int {
        return when (name) {
            "DesignSystem.Button.Confirm" -> R.style.DesignSystem_Button_Confirm
            else -> R.style.DesignSystem_Button_Default
        }
    }

    override fun image(name: String): Int {
        return when(name) {
            "full_star" -> R.drawable.ic_full_star
            "empty_star" -> R.drawable.ic_empty_star
            "half_star" -> R.drawable.ic_half_star
            "like" -> R.drawable.ic_like
            "ic_spotify" -> R.drawable.ic_spotify
            "ic_netflix" -> R.drawable.ic_netflix
            else -> R.drawable.ic_empty_star
        }
    }

    override fun theme(): Int {
        return R.style.AppTheme
    }

    override fun textAppearance(name: String): Int {
        return when (name) {
            "Design.TextAppearance.ShortDescriptionMovie" ->  R.style.Design_TextAppearance_ShortDescriptionMovie
            "Design.TextAppearance.TitleMovie" -> R.style.Design_TextAppearance_TitleMovie
            "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
            "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
            "Design.TextAppearance.TitleGenre" -> R.style.Design_TextAppearance_TitleGenre
            "Design.TextAppearance.Rating" -> R.style.Design_TextAppearance_Rating
            "Design.TextAppearance.RatingLabel" -> R.style.Design_TextAppearance_RatingLabel
            else -> R.style.DesignSystem_Text_Default
        }
    }
}
```

```javascript
// It is mandatory to initialize Beagle at the "onCreate method" in the class that extends the application class
override fun onCreate() {
        super.onCreate()

        BeagleInitializer
            .registerCustomActionHandler(AppCustomActionHandler())//It is the class that handles the custom actions
            .setup(appName, application, environment, baseURL)
            .registerWidget(CustomWidget::class.java)//It is the class that implements the customized widgets. Each custom widget must have a registerWidget
            .registerValidatorHandler(AppValidatorHandler())//The class that handles the validator class 
            .registerDesignSystem(AppDesignSystem())//The class that implements the DesignSystems
    } 

```

## How it works
The BFF will mediate the APIs that will be consumed and use Beagle to create layouts declaratively, serialize to JSON and send it to the Frontend.
In the Frontend, Beagle will deserialize this JSON into a widget and it will be rendered using the design system to a View.

<img src="./assets/BFF.png"/>

## Resources

* [FAQ](https://docs.google.com/spreadsheets/d/1S3Xnwsnc9GnN6R6wSpSfPsFeoaovrRQ9hbl6CZ6ONZE/edit#gid=0)

* [Detailed Guide](https://zupdocs.gitbook.io/beagle/)

* [Frontend example](https://github.com/ZupIT/beagle-tmdb)

* [BFF example](https://github.com/ZupIT/beagle-tmdb-backend)

## Testing
We are using the plugin [Shot](https://github.com/Karumi/Shot/) to run snapshots tests.

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
