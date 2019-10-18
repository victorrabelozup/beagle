package br.com.zup.beagleui.framework.config

import android.app.Application
import br.com.zup.beagleui.framework.config.networking.URLRequestDispatching
import br.com.zup.beagleui.framework.di.beagleModule
import com.facebook.soloader.SoLoader
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

object BeagleInitializer {
    internal lateinit var application: Application

    fun start(application: Application, networkingDispatcher: URLRequestDispatching? = null) {
        this.application = application

        //TODO store networkingDispatcher on BeagleEnviroment
        SoLoader.init(application, false)

        startKoin {
            androidContext(application)
            modules(listOf(beagleModule))
        }
    }
}
