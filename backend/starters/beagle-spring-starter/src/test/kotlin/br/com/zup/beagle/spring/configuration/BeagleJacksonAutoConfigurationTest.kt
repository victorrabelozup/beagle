/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.spring.configuration

import br.com.zup.beagle.serialization.jackson.BeagleModule
import com.fasterxml.jackson.databind.module.SimpleModule
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.boot.autoconfigure.AutoConfigurations
import org.springframework.boot.test.context.FilteredClassLoader
import org.springframework.boot.test.context.runner.ApplicationContextRunner

internal class BeagleJacksonAutoConfigurationTest {
    private val contextRunner by lazy {
        ApplicationContextRunner().withConfiguration(AutoConfigurations.of(BeagleJacksonAutoConfiguration::class.java))
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_sets_up_BeagleModule_in_context() {
        this.contextRunner.run {
            assertThat(it).hasSingleBean(SimpleModule::class.java)
            assertThat(it).getBean("beagleModule").isEqualTo(it.getBean(SimpleModule::class.java))
        }
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_does_not_set_up_BeagleModule_when_its_unavailable() {
        this.contextRunner.withClassLoader(FilteredClassLoader(BeagleModule::class.java))
            .run { assertThat(it).doesNotHaveBean(SimpleModule::class.java) }
    }
}