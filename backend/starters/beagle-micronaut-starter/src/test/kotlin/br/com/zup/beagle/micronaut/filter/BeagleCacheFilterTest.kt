/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.micronaut.filter

import br.com.zup.beagle.constants.BEAGLE_CACHE_ENABLED
import br.com.zup.beagle.micronaut.containsBeans
import io.micronaut.context.ApplicationContext
import org.junit.jupiter.api.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

internal class BeagleCacheFilterTest {
    @Test
    fun test_BeagleCacheFilter_is_in_context_by_default() {
        assertTrue { ApplicationContext.run().containsBeans(BeagleCacheFilter::class) }
    }

    @Test
    fun test_BeagleCacheFilter_is_in_context_when_enabled_is_true() {
        assertTrue {
            ApplicationContext.run(mapOf(BEAGLE_CACHE_ENABLED to true)).containsBeans(BeagleCacheFilter::class)
        }
    }

    @Test
    fun test_BeagleCacheFilter_is_not_in_context_when_enabled_is_false() {
        assertFalse {
            ApplicationContext.run(mapOf(BEAGLE_CACHE_ENABLED to false)).containsBeans(BeagleCacheFilter::class)
        }
    }
}