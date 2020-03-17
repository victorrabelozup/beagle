package br.com.zup.beagle.serialization.jackson

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper

object BeagleSerializationUtil {

    fun beagleObjectMapper() = jacksonObjectMapper().apply { this.registerModule(BeagleModule) }
}