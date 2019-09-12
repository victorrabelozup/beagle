package br.com.zup.beagleui.sample

import android.app.Application
import br.com.zup.beagleui.di.beagleModule
import com.facebook.soloader.SoLoader
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        SoLoader.init(this, false)

        startKoin {
            androidContext(this@BeagleUiSampleApplication)
            modules(listOf(beagleModule))
        }
    }

}