package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.di.beagleModule
import br.com.zup.beagleui.framework.networking.URLRequestDispatching
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import com.facebook.soloader.SoLoader
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

internal object BeagleEnvironment {

    lateinit var appName: String
        private set
    lateinit var application: Application
        private set

    var networkingDispatcher: URLRequestDispatching? = null
        private set

    val widgets: Map<Class<Widget>, WidgetViewFactory<Widget>>
        get() = internalWidgets

    private var internalWidgets = HashMap<Class<Widget>, WidgetViewFactory<Widget>>()

    fun setup(
        applicationName: String,
        application: Application,
        networkingDispatcher: URLRequestDispatching? = null
    ) {
        require(!::appName.isInitialized) { "You should not call setup() twice" }
        require(applicationName.isNotEmpty()) { "appName should be initialized with a non empty value" }

        this.appName = applicationName
        this.application = application
        this.networkingDispatcher = networkingDispatcher

        initialize()
    }

    private fun initialize() {
        SoLoader.init(application, false)

        startKoin {
            androidContext(application)
            modules(listOf(beagleModule))
        }
    }

    fun <T: Widget> registerWidget(clazz: Class<T>, factory: WidgetViewFactory<T>) {
        internalWidgets[clazz as Class<Widget>] = factory as WidgetViewFactory<Widget>
    }
}
