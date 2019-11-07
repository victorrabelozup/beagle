package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.action.CustomActionHandler
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.NativeWidget

class BeagleInitializer private constructor() {

    companion object {

        @JvmStatic
        fun setup(
            appName: String,
            application: Application
        ): Companion {
            BeagleEnvironment.setup(appName, application)
            return this
        }

        @JvmStatic
        fun <T: NativeWidget> registerWidget(
            clazz: Class<T>,
            factory: WidgetViewFactory<T>
        ): Companion {
            BeagleEnvironment.registerWidget(clazz, factory)
            return this
        }

        @JvmStatic
        fun registerHttpClient(httpClient: HttpClient): Companion {
            BeagleEnvironment.httpClient = httpClient
            return this
        }

        @JvmStatic
        fun registerTheme(theme: Theme): Companion {
            BeagleEnvironment.theme = theme
            return this
        }

        @JvmStatic
        fun registerBeagleDeepLinkHandler(beagleDeepLinkHandler: BeagleDeepLinkHandler): Companion {
            BeagleEnvironment.beagleDeepLinkHandler = beagleDeepLinkHandler
            return this
        }

        @JvmStatic
        fun registerCustomActionHandler(customActionHandler: CustomActionHandler): Companion {
            BeagleEnvironment.customActionHandler = customActionHandler
            return this
        }
    }
}
