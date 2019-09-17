object ApplicationId {
    const val id = "br.com.zup.beagleui.sample"
}

object Modules {
    const val sample = ":sample"
    const val beagleUi = ":beagle-ui"
}

object Releases {
    const val versionCode = 1
    const val versionName = "1.0"
}

object Versions {
    const val compileSdk = 29
    const val minSdk = 19
    const val targetSdk = 29
    const val buildTools = "29.0.2"

    const val kotlin = "1.3.41"
    const val kotlinCoroutines = "1.3.1"

    const val appcompat = "1.1.0"
    const val viewModel = "2.1.0"

    const val koin = "2.0.1"

    const val litho = "0.31.0"

    const val fresco = "2.0.0"

    const val moshi = "1.8.0"

    const val soLoader = "0.5.1"

    const val junit = "4.12"

    const val androidxRunner = "1.2.0"

    const val espressoCore = "3.2.0"
}

object GeneralNames {
    const val testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    const val consumerProguard = "consumer-rules.pro"
}

object GeneralLibraries {
    const val kotlin = "org.jetbrains.kotlin:kotlin-stdlib-jdk7:${Versions.kotlin}"
    const val kotlinCoroutines = "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.kotlinCoroutines}"

    const val koin = "org.koin:koin-androidx-viewmodel:${Versions.koin}"

    const val fresco = "com.facebook.fresco:fresco:${Versions.fresco}"

    const val soLoader = "com.facebook.soloader:soloader:${Versions.soLoader}"
}

object AndroidxLibraries {
    const val appcompat = "androidx.appcompat:appcompat:${Versions.appcompat}"
    const val coreKtx = "androidx.core:core-ktx:${Versions.appcompat}"
    const val viewModel = "androidx.lifecycle:lifecycle-viewmodel:${Versions.viewModel}"
}

object LithoLibraries {
    const val core = "com.facebook.litho:litho-core:${Versions.litho}"
    const val widget = "com.facebook.litho:litho-widget:${Versions.litho}"
    const val processor = "com.facebook.litho:litho-processor:${Versions.litho}"
    const val fresco = "com.facebook.litho:litho-fresco:${Versions.litho}"
}

object MoshiLibraries {
    const val moshi = "com.squareup.moshi:moshi:${Versions.moshi}"
    const val kotlin = "com.squareup.moshi:moshi-kotlin:${Versions.moshi}"
    const val adapters = "com.squareup.moshi:moshi-adapters:${Versions.moshi}"
}

object TestLibraries {
    const val junit = "junit:junit:${Versions.junit}"
    const val litho = "com.facebook.litho:litho-testing:${Versions.litho}"
    const val mockk = ""
    const val androidxRunner = "androidx.test:runner:${Versions.androidxRunner}"
    const val espressoCore = "androidx.test.espresso:espresso-core:${Versions.espressoCore}"
}
