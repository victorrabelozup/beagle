package br.com.zup.beagle.sample

import android.app.Application

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleSetup().init(this)
    }
}
