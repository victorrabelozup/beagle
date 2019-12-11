package br.com.zup.beagle.starter.config

import br.com.zup.beagleui.framework.widget.core.Widget

internal object BeagleEnvironment {

    lateinit var appName: String
        private set

    val widgets: List<Class<Widget>>
        get() = internalWidgets

    private var internalWidgets = mutableListOf<Class<Widget>>()

    fun setup(applicationName: String) {
        require(!::appName.isInitialized) { "You should not call setup() twice" }
        require(applicationName.isNotEmpty()) { "appName should be initialized with a non empty value" }

        this.appName = applicationName
    }

    fun <T: Widget> registerWidget(clazz: Class<T>) {
        internalWidgets.add(clazz as Class<Widget>)
    }
}