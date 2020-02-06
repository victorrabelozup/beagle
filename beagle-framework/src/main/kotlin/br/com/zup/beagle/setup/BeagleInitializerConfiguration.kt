package br.com.zup.beagle.setup

import java.util.*
import kotlin.system.exitProcess

object BeagleInitializerConfiguration {

    private const val BEAGLE_APPLICATION_NAME_PROPERTY = "beagle.application.name"
    private const val PROPERTIES_FILE = "application.properties"


    fun getBeagleApplicationNameOrExitWithFailure(): String {
        val properties = Properties()
        var hasBeagleApplicationProperty = false
        var applicationName = ""
        this::class.java.classLoader.getResourceAsStream(PROPERTIES_FILE)?.use {
            properties.load(it)
            hasBeagleApplicationProperty = properties.containsKey(BEAGLE_APPLICATION_NAME_PROPERTY)
            if (hasBeagleApplicationProperty) {
                applicationName = properties[BEAGLE_APPLICATION_NAME_PROPERTY] as String
            }
        }
        if (!hasBeagleApplicationProperty) {
            println("Property '$BEAGLE_APPLICATION_NAME_PROPERTY' was not found on $PROPERTIES_FILE")
            exitProcess(1)
        }
        return applicationName
    }
}