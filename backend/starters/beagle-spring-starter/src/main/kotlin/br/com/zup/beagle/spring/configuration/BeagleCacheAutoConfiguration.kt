/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.spring.configuration

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.constants.BEAGLE_CACHE_ENABLED
import br.com.zup.beagle.constants.BEAGLE_CACHE_EXCLUDES
import br.com.zup.beagle.constants.BEAGLE_CACHE_INCLUDES
import br.com.zup.beagle.spring.filter.BeagleCacheFilter
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
@ConditionalOnClass(value = [BeagleCacheFilter::class, BeagleCacheHandler::class])
@ConditionalOnProperty(value = [BEAGLE_CACHE_ENABLED], matchIfMissing = true, havingValue = "true")
open class BeagleCacheAutoConfiguration(
    @Value("\${$BEAGLE_CACHE_INCLUDES:*}") private val includeEndpointList: List<String>,
    @Value("\${$BEAGLE_CACHE_EXCLUDES:}") private val excludeEndpointList: List<String>
) {
    @Bean
    open fun beagleCachingFilter(cacheHandler: BeagleCacheHandler) =
        FilterRegistrationBean<BeagleCacheFilter>().also {
            it.filter = BeagleCacheFilter(cacheHandler)
            it.addUrlPatterns(*this.includeEndpointList.toTypedArray())
        }

    @Bean
    open fun beagleCacheHandler() = BeagleCacheHandler(this.excludeEndpointList)
}