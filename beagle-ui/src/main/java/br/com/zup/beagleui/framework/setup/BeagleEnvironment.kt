package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.di.beagleModule
import br.com.zup.beagleui.framework.networking.URLRequestDispatching
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import com.facebook.soloader.SoLoader
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

internal object BeagleEnvironment {

    lateinit var appName: String
        private set
    lateinit var application: Application
        private set

    var networkingDispatcher: URLRequestDispatching? = null

    var theme: Theme? = null

    val widgets: Map<Class<NativeWidget>, WidgetViewFactory<NativeWidget>>
        get() = internalWidgets

    private var internalWidgets = HashMap<Class<NativeWidget>, WidgetViewFactory<NativeWidget>>()

    fun setup(
        applicationName: String,
        application: Application
    ) {
        require(!::appName.isInitialized) { "You should not call setup() twice" }
        require(applicationName.isNotEmpty()) { "appName should be initialized with a non empty value" }

        this.appName = applicationName
        this.application = application

        initialize()
    }

    private fun initialize() {
        SoLoader.init(application, false)

        startKoin {
            androidContext(application)
            modules(listOf(beagleModule))
        }
    }

    fun <T: NativeWidget> registerWidget(clazz: Class<T>, factory: WidgetViewFactory<T>) {
        internalWidgets[clazz as Class<NativeWidget>] = factory as WidgetViewFactory<NativeWidget>
    }
}
