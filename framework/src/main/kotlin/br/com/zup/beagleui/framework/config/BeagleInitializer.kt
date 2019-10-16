package br.com.zup.beagleui.framework.config

object BeagleInitializer {
    internal lateinit var configuration: Configuration
        private set

    fun setup(configuration: Configuration) {
        this.configuration = configuration
    }
}

data class Configuration(
        val appName: String,
        val widgets: List<Class<*>>
)