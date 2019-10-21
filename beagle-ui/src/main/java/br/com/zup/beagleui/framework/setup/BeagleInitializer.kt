package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.networking.URLRequestDispatching
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget

class BeagleInitializer {

    companion object {

        @JvmStatic
        fun setup(
            appName: String,
            application: Application,
            networkingDispatcher: URLRequestDispatching? = null
        ) {
            BeagleEnvironment.setup(appName, application, networkingDispatcher)
        }

        @JvmStatic
        fun <T: Widget> registerWidget(
            clazz: Class<T>,
            factory: WidgetViewFactory<T>
        ): Companion {
            BeagleEnvironment.registerWidget(clazz, factory)
            return this
        }
    }
}
