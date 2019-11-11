object ApplicationId {
    const val id = "br.com.zup.beagleui.sample"
}

object Modules {
    const val sample = ":sample"
    const val beagleUi = ":beagle-ui"
    const val libfb = ":libfb"
    const val yoga = ":yoga"
}

object Releases {
    const val versionCode = 1
    const val versionName = "1.0"
    const val beagleUiVersionName = "0.0.1-alpha2"
    const val yogaVersionName = "0.0.1-alpha1"
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
    const val recyclerView = "1.0.0"

    const val litho = "0.31.0"

    const val fresco = "2.0.0"

    const val moshi = "1.8.0"

    const val soLoader = "0.5.1"

    const val findsBug = "3.0.1"

    const val beagleDeclarative = "0.0.7"

    const val glide = "4.9.0"

    const val junit = "4.12"

    const val kotlinTest = "1.3.50"
    const val kotlinCoroutinesTest = "1.3.1"

    const val mockk = "1.9.3"

    const val testRunner = "1.2.0"
    const val testExt = "1.1.1"
    const val archCoreTesting = "2.0.1"
    const val espressoCore = "3.2.0"
}

object GeneralNames {
    const val testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    const val consumerProguard = "consumer-rules.pro"
}

object GlideLibraries {
    const val glide = "com.github.bumptech.glide:glide:${Versions.glide}"
    const val glideCompiler = "com.github.bumptech.glide:compiler:${Versions.glide}"
}

object GeneralLibraries {
    const val kotlin = "org.jetbrains.kotlin:kotlin-stdlib-jdk7:${Versions.kotlin}"
    const val kotlinCoroutines = "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.kotlinCoroutines}"

    const val fresco = "com.facebook.fresco:fresco:${Versions.fresco}"

    const val soLoader = "com.facebook.soloader:soloader:${Versions.soLoader}"

    const val findsBug = "com.google.code.findbugs:jsr305:${Versions.findsBug}"

    const val beagleDeclarative = "br.com.zup:beagle-ui-sdk:${Versions.beagleDeclarative}"
    const val yoga = "br.com.zup.beagleui:yoga:${Releases.yogaVersionName}"
}

object AndroidxLibraries {
    const val appcompat = "androidx.appcompat:appcompat:${Versions.appcompat}"
    const val coreKtx = "androidx.core:core-ktx:${Versions.appcompat}"
    const val recyclerView = "androidx.recyclerview:recyclerview:${Versions.recyclerView}"
    const val viewModel = "androidx.lifecycle:lifecycle-viewmodel:${Versions.viewModel}"
    const val viewModelExtensions = "androidx.lifecycle:lifecycle-extensions:${Versions.viewModel}"
}

object MoshiLibraries {
    const val moshi = "com.squareup.moshi:moshi:${Versions.moshi}"
    const val kotlin = "com.squareup.moshi:moshi-kotlin:${Versions.moshi}"
    const val adapters = "com.squareup.moshi:moshi-adapters:${Versions.moshi}"
}

object TestLibraries {
    const val junit = "junit:junit:${Versions.junit}"
    const val mockk = "io.mockk:mockk:${Versions.mockk}"
    const val kotlinTest = "org.jetbrains.kotlin:kotlin-test:${Versions.kotlinTest}"
    const val kotlinCoroutinesTest = "org.jetbrains.kotlinx:kotlinx-coroutines-test:${Versions.kotlinCoroutinesTest}"
    const val testRunner = "androidx.test:runner:${Versions.testRunner}"
    const val testExt = "androidx.test.ext:junit:${Versions.testExt}"
    const val archCoreTesting = "androidx.arch.core:core-testing:${Versions.archCoreTesting}"
    const val espressoCore = "androidx.test.espresso:espresso-core:${Versions.espressoCore}"
}
