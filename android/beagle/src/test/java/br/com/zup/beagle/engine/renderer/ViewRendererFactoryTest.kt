/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.core.ServerDrivenComponent
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import org.junit.Before
import org.junit.Test
import kotlin.test.assertTrue

class ViewRendererFactoryTest {

    @MockK
    private lateinit var layoutViewRendererFactory: LayoutViewRendererFactory
    @MockK
    private lateinit var uiViewRendererFactory: UIViewRendererFactory

    @MockK
    private lateinit var component: ServerDrivenComponent

    private lateinit var viewRendererFactory: ViewRendererFactory

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        viewRendererFactory = ViewRendererFactory(layoutViewRendererFactory, uiViewRendererFactory)

        every { layoutViewRendererFactory.make(any()) } returns mockk<LayoutViewRenderer<*>>()
        every { uiViewRendererFactory.make(any()) } returns mockk<UIViewRenderer<*>>()
    }

    @Test
    fun make_should_return_a_LayoutViewRenderer() {
        val actual = viewRendererFactory.make(component)

        assertTrue(actual is LayoutViewRenderer)
    }

    @Test
    fun make_should_return_a_UIViewRenderer() {
        // Given
        every { viewRendererFactory.make(component) } throws IllegalArgumentException()

        // When
        val actual = viewRendererFactory.make(component)

        // Then
        assertTrue(actual is UIViewRenderer)
    }
}