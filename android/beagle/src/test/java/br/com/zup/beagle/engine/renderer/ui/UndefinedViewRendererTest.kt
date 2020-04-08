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
import android.widget.TextView
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.Environment
import br.com.zup.beagle.view.BeagleTextView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.UndefinedWidget
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.slot
import io.mockk.verify
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class UndefinedViewRendererTest : BaseTest() {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var textView: BeagleTextView
    @RelaxedMockK
    private lateinit var undefinedWidget: UndefinedWidget

    private val textSlot = slot<String>()
    private val textColorSlot = slot<Int>()
    private val backgroundColorSlot = slot<Int>()

    @InjectMockKs
    private lateinit var undefinedViewRenderer: UndefinedViewRenderer

    override fun setUp() {
        super.setUp()

        every { BeagleEnvironment.beagleSdk.config.environment } returns Environment.DEBUG
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.text = capture(textSlot) } just Runs
        every { textView.setTextColor(capture(textColorSlot)) } just Runs
        every { textView.setBackgroundColor(capture(backgroundColorSlot)) } just Runs
        every { rootView.getContext() } returns context
    }

    @Test
    fun build_should_create_a_TexView_with_a_undefinedWidget_text() {
        val actual = undefinedViewRenderer.build(rootView)

        assertTrue(actual is TextView)
        assertEquals("undefined component", textSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_textColor_RED() {
        undefinedViewRenderer.build(rootView)

        assertEquals(Color.RED, textColorSlot.captured)
    }

    @Test
    fun build_should_create_a_TexView_with_a_backgroundColor_YELLOW() {
        undefinedViewRenderer.build(rootView)

        assertEquals(Color.YELLOW, backgroundColorSlot.captured)
    }

    @Test
    fun build_should_create_View_when_Environment_is_PRODUCTION() {
        // Given
        every { BeagleEnvironment.beagleSdk.config.environment } returns Environment.PRODUCTION
        every { viewFactory.makeView(any()) } returns textView

        // When
        undefinedViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { viewFactory.makeView(context) }
    }
}