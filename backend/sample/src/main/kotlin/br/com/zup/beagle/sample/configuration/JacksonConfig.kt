package br.com.zup.beagle.sample.configuration

import br.com.zup.beagle.serialization.jackson.BeagleSerializationUtil
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
open class JacksonConfig {
    @Bean
    open fun objectMapper() = BeagleSerializationUtil.beagleObjectMapper()
}