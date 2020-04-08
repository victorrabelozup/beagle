/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.micronaut.configuration

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.micronaut.containsBeans
import io.micronaut.context.ApplicationContext
import org.junit.jupiter.api.Test
import kotlin.test.assertTrue

internal class BeagleCacheConfigurationTest {
    @Test
    fun test_BeagleCacheConfiguration_sets_up_BeagleCacheHandler_in_context() {
        assertTrue { ApplicationContext.run().containsBeans(BeagleCacheConfiguration::class, BeagleCacheHandler::class) }
    }
}