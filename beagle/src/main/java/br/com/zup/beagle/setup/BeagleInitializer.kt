package br.com.zup.beagle.setup

import android.app.Application
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.form.ValidatorHandler
import br.com.zup.beagle.navigation.BeagleDeepLinkHandler
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.view.WidgetViewFactory
import br.com.zup.beagle.widget.core.Widget

enum class Environment {
    DEBUG,
    PRODUCTION
}

class BeagleInitializer private constructor() {

    companion object {

        @JvmStatic
        fun setup(
            appName: String,
            application: Application,
            environment: Environment,
            baseUrl: String
        ): Companion {
            BeagleEnvironment.setup(appName, application, environment, baseUrl)
            return this
        }

        @JvmStatic
        fun <T: Widget> registerWidget(
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
        fun registerDesignSystem(designSystem: DesignSystem) {
            BeagleEnvironment.designSystem = designSystem
        }

        @JvmStatic
        fun registerBeagleDeepLinkHandler(beagleDeepLinkHandler: BeagleDeepLinkHandler): Companion {
            BeagleEnvironment.beagleDeepLinkHandler = beagleDeepLinkHandler
            return this
        }

        @JvmStatic
        fun registerValidatorHandler(validatorHandler: ValidatorHandler): Companion {
            BeagleEnvironment.validatorHandler = validatorHandler
            return this
        }

        @JvmStatic
        fun registerCustomActionHandler(customActionHandler: CustomActionHandler): Companion {
            BeagleEnvironment.customActionHandler = customActionHandler
            return this
        }
    }
}
