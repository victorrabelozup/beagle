package br.com.zup.beagle.spring.configuration

import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.SerializationFeature
import org.springframework.boot.context.properties.ConfigurationProperties

@ConfigurationProperties(prefix = "beagle.serialization")
open class BeagleSerializationProperties(
    var include: JsonInclude.Include = JsonInclude.Include.NON_NULL,
    var features: List<SerializationFeature> = listOf(SerializationFeature.INDENT_OUTPUT)
)