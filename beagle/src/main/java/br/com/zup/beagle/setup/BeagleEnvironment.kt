package br.com.zup.beagle.setup

import android.app.Application
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.form.ValidatorHandler
import br.com.zup.beagle.navigation.BeagleDeepLinkHandler
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.view.WidgetViewFactory
import br.com.zup.beagle.widget.core.Widget
import com.facebook.soloader.SoLoader

internal object BeagleEnvironment {

    lateinit var appName: String
        private set
    lateinit var application: Application
        private set
    lateinit var environment: Environment
        private set
    lateinit var baseUrl: String
        private set
    private var internalWidgets =
        mutableMapOf<Class<Widget>, WidgetViewFactory<Widget>>()

    // SDK Configurations
    var validatorHandler: ValidatorHandler? = null
    var httpClient: HttpClient? = null
    var beagleDeepLinkHandler: BeagleDeepLinkHandler? = null
    var customActionHandler: CustomActionHandler? = null
    var designSystem: DesignSystem? = null
    val widgets: Map<Class<Widget>, WidgetViewFactory<Widget>>
        get() = internalWidgets

    fun setup(
        applicationName: String,
        application: Application,
        environment: Environment,
        baseUrl: String
    ) {
        require(!::appName.isInitialized) { "You should not call setup() twice" }
        require(applicationName.isNotEmpty()) { "appName should be initialized with a non empty value" }

        this.appName = applicationName
        this.application = application
        this.environment = environment
        this.baseUrl = baseUrl

        initialize()
    }

    private fun initialize() {
        SoLoader.init(application, false)
    }

    @Suppress("UNCHECKED_CAST")
    fun <T : Widget> registerWidget(clazz: Class<T>, factory: WidgetViewFactory<T>) {
        internalWidgets[clazz as Class<Widget>] = factory as WidgetViewFactory<Widget>
    }
}
