package br.com.zup.beagle.sample.configuration

import br.com.zup.beagle.serialization.jackson.BeagleActionSerializer
import br.com.zup.beagle.serialization.jackson.BeagleComponentSerializer
import br.com.zup.beagle.serialization.jackson.BeagleScreenBuilderSerializer
import br.com.zup.beagle.serialization.jackson.BeagleScreenSerializer
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
open class JacksonConfig {
    @Bean
    open fun objectMapper(): ObjectMapper {
        val module = SimpleModule().apply {
            this.addSerializer(BeagleActionSerializer())
            this.addSerializer(BeagleComponentSerializer())
            this.addSerializer(BeagleScreenSerializer())
            this.addSerializer(BeagleScreenBuilderSerializer())
        }

        return jacksonObjectMapper().apply {
            this.registerModule(module)
            this.setDefaultPropertyInclusion(JsonInclude.Include.NON_NULL)
        }
    }
}