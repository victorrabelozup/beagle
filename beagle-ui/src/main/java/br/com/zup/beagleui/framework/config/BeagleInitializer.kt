package br.com.zup.beagleui.framework.config

import android.app.Application
import br.com.zup.beagleui.framework.di.beagleModule
import com.facebook.soloader.SoLoader
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

object BeagleInitializer {
    internal lateinit var application: Application

    fun start(application: Application) {
        this.application = application

        SoLoader.init(application, false)

        startKoin {
            androidContext(application)
            modules(listOf(beagleModule))
        }
    }
}
