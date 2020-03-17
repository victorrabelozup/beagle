package br.com.zup.beagle.spring.configuration

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.spring.filter.CacheFilter
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
@ConditionalOnClass(value = [CacheFilter::class, BeagleCacheHandler::class])
@ConditionalOnProperty(
    value = ["beagle.cache.enabled"],
    matchIfMissing = true,
    havingValue = "true"
)
open class BeagleCacheAutoConfiguration(
    @Value("\${beagle.cache.endpoint.include:*}") val includeEndpointList: List<String>,
    @Value("\${beagle.cache.endpoint.exclude:}") val excludeEndpointList: List<String>
) {

    @Bean
    open fun beagleCachingFilter() = FilterRegistrationBean<CacheFilter>().apply {
        this.filter = CacheFilter(excludeEndpointList)
        this.addUrlPatterns(*includeEndpointList.toTypedArray())
    }
}