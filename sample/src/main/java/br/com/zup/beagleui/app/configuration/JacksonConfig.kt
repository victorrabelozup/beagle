package br.com.zup.beagleui.app.configuration

import br.com.zup.beagleui.framework.serialization.jackson.BeagleWidgetSerializer
import com.fasterxml.jackson.annotation.JsonInclude
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder

@Configuration
open class JacksonConfig {

    @Bean
    open fun jacksonBuilder(): Jackson2ObjectMapperBuilder {
        return Jackson2ObjectMapperBuilder()
            .serializationInclusion(JsonInclude.Include.NON_NULL)
            .serializers(BeagleWidgetSerializer())
    }
}