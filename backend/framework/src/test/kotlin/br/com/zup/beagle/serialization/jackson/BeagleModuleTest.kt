package br.com.zup.beagle.serialization.jackson

import org.junit.jupiter.api.Test
import kotlin.reflect.KProperty1
import kotlin.reflect.KVisibility
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible
import kotlin.test.assertTrue

internal class BeagleModuleTest {
    @Test
    fun beagleModule_should_be_initialized_with_BeagleSerializerModifier() {
        assertTrue {
            BeagleModule::class.memberProperties
                .find { it.name == "_serializerModifier" }
                ?.run {
                    this.isAccessible = true
                    this.get(BeagleModule) is BeagleSerializerModifier
                }!!
        }
    }
}