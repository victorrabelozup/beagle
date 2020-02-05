package br.com.zup.beagle.sample

import android.app.Application
import br.com.zup.beagle.setup.BeagleInitializer
import br.com.zup.beagle.setup.Environment
import br.com.zup.beagle.sample.widgets.TextField
import br.com.zup.beagle.sample.widgets.MutableText

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleInitializer
            .registerCustomActionHandler(AppCustomActionHandler())
            .setup("sample", this, Environment.DEBUG, "https://t001-2751a.firebaseapp.com/")
            .registerWidget(TextField::class.java)
            .registerWidget(MutableText::class.java)
            .registerValidatorHandler(AppValidatorHandler())
            .registerDesignSystem(AppDesignSystem())
    }
}
