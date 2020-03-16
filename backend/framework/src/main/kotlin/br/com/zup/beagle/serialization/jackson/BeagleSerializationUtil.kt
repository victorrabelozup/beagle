package br.com.zup.beagle.serialization.jackson

import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.SerializationFeature
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper

object BeagleSerializationUtil {

    fun beagleObjectMapper() = jacksonObjectMapper().apply {
        this.registerModule(BeagleModule)
        this.enable(SerializationFeature.INDENT_OUTPUT)
        this.setDefaultPropertyInclusion(JsonInclude.Include.NON_NULL)
    }
}