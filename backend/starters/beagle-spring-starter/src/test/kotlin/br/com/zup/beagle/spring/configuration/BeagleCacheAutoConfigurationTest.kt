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
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.boot.autoconfigure.AutoConfigurations
import org.springframework.boot.test.context.FilteredClassLoader
import org.springframework.boot.test.context.assertj.AssertableApplicationContext
import org.springframework.boot.test.context.runner.ApplicationContextRunner
import org.springframework.boot.web.servlet.FilterRegistrationBean
import java.util.regex.Pattern
import kotlin.test.assertTrue


internal class BeagleCacheAutoConfigurationTest {

    private val contextRunner by lazy {
        ApplicationContextRunner().withConfiguration(AutoConfigurations.of(BeagleCacheAutoConfiguration::class.java))
    }

    private val cacheFilterBeanName = "beagleCachingFilter"
    private val includesField = "includeEndpointList"
    private val excludesField = "excludeEndpointList"

    @Test
    fun beagleCacheAutoConfiguration_must_not_be_present_with_enabled_property_false() {
        this.contextRunner.withPropertyValues("$BEAGLE_CACHE_ENABLED=false").run {
            validateCacheFilter(it, true)
        }
    }

    @Test
    fun beagleCacheAutoConfiguration_must_be_present_with_enabled_property_true_or_absent() {
        this.contextRunner.withPropertyValues("$BEAGLE_CACHE_ENABLED=true").run {
            validateCacheFilter(it)
        }
        this.contextRunner.run {
            validateCacheFilter(it)
        }
    }

    @Test
    fun beagleCacheAutoConfiguration_must_not_be_present_without_required_classes() {
        val filterClassLoader = FilteredClassLoader(BeagleCacheFilter::class.java, BeagleCacheHandler::class.java)
        this.contextRunner.withClassLoader(filterClassLoader).run {
            validateCacheFilter(it, true)
        }
    }

    @Test
    fun beagleCacheAutoConfiguration_must_be_present_with_default_value_for_properties() {
        this.contextRunner.run {
            validateCacheFilter(it)
            assertThat(it).getBean(BeagleCacheAutoConfiguration::class.java).hasFieldOrPropertyWithValue(this.includesField, listOf("*"))
            assertThat(it).getBean(BeagleCacheAutoConfiguration::class.java).hasFieldOrPropertyWithValue(this.excludesField, listOf(""))
        }
    }

    @Test
    fun cacheFilter_must_be_present_and_match_url_pattern() {
        this.contextRunner.withPropertyValues("$BEAGLE_CACHE_INCLUDES=/te*").run {
            validateCacheFilter(it)
            val cacheFilter = (it.getBean(this.cacheFilterBeanName) as FilterRegistrationBean<*>)
            assertTrue {
                cacheFilter.urlPatterns.map(Pattern::compile).any { pattern ->
                    pattern.matcher("/text").find()
                }
            }
        }
    }

    @Test
    fun beagleCacheAutoConfiguration_must_fail_to_start_with_invalid_excludes_property() {
        this.contextRunner.withPropertyValues("$BEAGLE_CACHE_EXCLUDES=?").run {
            assertThat(it).hasFailed()
        }
    }

    private fun validateCacheFilter(context: AssertableApplicationContext, toNotExists: Boolean = false) {
        if (toNotExists) {
            assertThat(context).doesNotHaveBean(BeagleCacheAutoConfiguration::class.java)
            assertThat(context).doesNotHaveBean(FilterRegistrationBean::class.java)
        } else {
            val cacheFilter = (context.getBean(this.cacheFilterBeanName) as FilterRegistrationBean<*>).filter
            assertThat(context).hasSingleBean(BeagleCacheAutoConfiguration::class.java)
            assertTrue(cacheFilter is BeagleCacheFilter)
        }
    }
}