package br.com.zup.beagle.setup

import br.com.zup.beagle.widget.core.Widget

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
