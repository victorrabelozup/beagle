package br.com.zup.beagle.framework.config

import br.com.zup.beagle.declarative.widget.core.Widget

class BeagleInitializer {
    companion object {
        @JvmStatic
        fun setup(applicationName: String): Companion {
            BeagleEnvironment.setup(applicationName)
            return this
        }

        @JvmStatic
        fun <T: Widget> registerWidget(clazz: Class<T>): Companion {
            BeagleEnvironment.registerWidget(clazz)
            return this
        }
    }
}
