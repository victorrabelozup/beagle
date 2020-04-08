/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Vertical
import io.mockk.impl.annotations.MockK
import org.junit.Assert.assertEquals
import org.junit.Test

class VerticalViewRenderTest : BaseTest() {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @Test
    fun getYogaFlexDirection_should_return_COLUMN_REVERSE_when_reversed_is_true() {
        // Given
        val verticalViewRenderer = VerticalViewRender(
            Vertical(listOf(), reversed = true),
            viewRendererFactory,
            viewFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(FlexDirection.COLUMN_REVERSE, actual)
    }

    @Test
    fun getYogaFlexDirection_should_return_COLUMN_when_reversed_is_false() {
        // Given
        val verticalViewRenderer = VerticalViewRender(
            Vertical(listOf(), reversed = false),
            viewRendererFactory,
            viewFactory
        )

        // When
        val actual = verticalViewRenderer.getYogaFlexDirection()

        // Then
        assertEquals(FlexDirection.COLUMN, actual)
    }
}