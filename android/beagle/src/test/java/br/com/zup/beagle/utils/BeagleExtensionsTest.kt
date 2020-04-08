/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleActivity
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertNotNull

class BeagleExtensionsTest {

    @RelaxedMockK
    private lateinit var beagleActivity: BeagleActivity

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
    }

    @Test
    fun configureSupportActionBarShouldSetSupportActionBar() {
        every { beagleActivity.supportActionBar } returns null

        beagleActivity.configureSupportActionBar()

        verify(exactly = once()) { beagleActivity.setSupportActionBar(any()) }
    }
}