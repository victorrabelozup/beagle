package br.com.zup.beagleui.sample

import android.app.Application
import br.com.zup.beagleui.framework.setup.BeagleInitializer
import br.com.zup.beagleui.framework.setup.Environment
import br.com.zup.beagleui.sample.widgets.TextField
import br.com.zup.beagleui.sample.widgets.TextFieldViewFactory

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleInitializer
            .registerCustomActionHandler(AppCustomActionHandler())
            .setup("sample", this, Environment.DEBUG, "https://t001-2751a.firebaseapp.com/")
            .registerWidget(TextField::class.java, TextFieldViewFactory())
            .registerDesignSystem(AppDesignSystem(this))
    }
}