package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.form.ValidatorHandler
import br.com.zup.beagleui.framework.action.CustomActionHandler
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import com.facebook.soloader.SoLoader

internal object BeagleEnvironment {

    lateinit var appName: String
        private set
    lateinit var application: Application
        private set
    lateinit var environment: Environment
        private set
    private var internalWidgets = mutableMapOf<Class<NativeWidget>, WidgetViewFactory<NativeWidget>>()

    // SDK Configurations
    var validatorHandler: ValidatorHandler? = null
    var httpClient: HttpClient? = null
    var beagleDeepLinkHandler: BeagleDeepLinkHandler? = null
    var customActionHandler: CustomActionHandler? = null
    var theme: Theme? = null
    val widgets: Map<Class<NativeWidget>, WidgetViewFactory<NativeWidget>>
        get() = internalWidgets

    fun setup(
        applicationName: String,
        application: Application,
        environment: Environment
    ) {
        require(!::appName.isInitialized) { "You should not call setup() twice" }
        require(applicationName.isNotEmpty()) { "appName should be initialized with a non empty value" }

        this.appName = applicationName
        this.application = application
        this.environment = environment

        initialize()
    }

    private fun initialize() {
        SoLoader.init(application, false)
    }

    @Suppress("UNCHECKED_CAST")
    fun <T : NativeWidget> registerWidget(clazz: Class<T>, factory: WidgetViewFactory<T>) {
        internalWidgets[clazz as Class<NativeWidget>] = factory as WidgetViewFactory<NativeWidget>
    }
}
