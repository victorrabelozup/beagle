package br.com.zup.beagle.serialization.jackson

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test

internal class BeagleSerializationUtilKtTest {

    @Test
    fun beagleObjectMapper_function_returns_mapper_with_beagleModule() {
        val mapper = BeagleSerializationUtil.beagleObjectMapper()
        assertTrue(mapper.registeredModuleIds.contains(BeagleModule.typeId))
    }
}