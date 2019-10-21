package br.com.zup.beagleui.sample

import android.app.Application
import br.com.zup.beagleui.framework.setup.BeagleInitializer

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleInitializer.setup("sample", this)
    }
}
