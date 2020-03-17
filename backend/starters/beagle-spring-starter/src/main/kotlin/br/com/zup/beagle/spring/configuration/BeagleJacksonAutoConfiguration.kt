package br.com.zup.beagle.spring.configuration

import br.com.zup.beagle.serialization.jackson.BeagleSerializationUtil
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
@ConditionalOnClass(BeagleSerializationUtil::class)
@EnableConfigurationProperties(BeagleSerializationProperties::class)
open class BeagleJacksonAutoConfiguration(private val serializationProperties: BeagleSerializationProperties) {
    @Bean
    @ConditionalOnMissingBean
    open fun objectMapper() = BeagleSerializationUtil.beagleObjectMapper().also { mapper ->
        mapper.setSerializationInclusion(this.serializationProperties.include)
        this.serializationProperties.features.forEach { mapper.enable(it) }
    }
}