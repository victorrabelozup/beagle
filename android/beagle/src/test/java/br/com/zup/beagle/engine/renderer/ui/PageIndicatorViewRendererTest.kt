/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.graphics.Color
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.testutil.setPrivateField
import br.com.zup.beagle.view.BeaglePageIndicatorView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.pager.PageIndicator
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockkStatic
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class PageIndicatorViewTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var beaglePageIndicatorView: BeaglePageIndicatorView

    private lateinit var pageIndicator: PageIndicator

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        pageIndicator = PageIndicator(RandomData.string(), RandomData.string(), viewFactory).apply {
            setPrivateField("pageIndicator", beaglePageIndicatorView)
        }

        mockkStatic(Color::class)

        every { Color.parseColor(any()) } returns 0
        every { viewFactory.makePageIndicator(any()) } returns beaglePageIndicatorView
    }

    @Test
    fun toView_should_return_BeaglePageIndicatorView_and_set_colors() {
        val view = pageIndicator.toView(context)

        assertEquals(beaglePageIndicatorView, view)
        verify(exactly = once()) { beaglePageIndicatorView.setSelectedColor(0) }
        verify(exactly = once()) { beaglePageIndicatorView.setUnselectedColor(0) }
    }

    @Test
    fun setCount_should_call_BeaglePageIndicatorView_setCount() {
        // Given
        val count = RandomData.int()

        // When
        pageIndicator.setCount(count)

        // Then
        verify(exactly = once()) { beaglePageIndicatorView.setCount(count) }
    }

    @Test
    fun onItemUpdated_should_call_BeaglePageIndicatorView_onItemUpdated() {
        // Given
        val count = RandomData.int()

        // When
        pageIndicator.onItemUpdated(count)

        // Then
        verify(exactly = once()) { beaglePageIndicatorView.setCurrentIndex(count) }
    }
}