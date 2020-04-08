/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.data.cache

import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.testutil.RandomData
import io.mockk.mockk
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

class BeagleCacheHelperTest {

    private val subject = BeagleCacheHelper

    private val url = RandomData.httpUrl()

    private val component = mockk<ServerDrivenComponent>(relaxUnitFun = true)

    @Test
    fun test_cache_should_return_get_cached_value() {
        //given
        subject.cache(url, component)

        //when
        val result = subject.getFromCache(url)

        //then
        assertEquals(component, result)
    }

    @Test
    fun test_cache_should_return_get_no_cached_value() {
        //Given
        val expectedUrl = RandomData.httpUrl()

        //when
        val result = subject.getFromCache(expectedUrl)

        //then
        assertNull(result)
    }
}