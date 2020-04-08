/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.widget.TextView
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.view.BeagleTextView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.view.setTextWidget
import br.com.zup.beagle.widget.ui.Text
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.unmockkAll
import io.mockk.verify
import org.junit.Test
import kotlin.test.assertTrue

private const val DEFAULT_TEXT = "Hello"
private const val DEFAULT_STYLE = "DummyStyle"

class TextViewRendererTest : BaseTest() {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var textView: BeagleTextView
    @RelaxedMockK
    private lateinit var text: Text
    @MockK
    private lateinit var rootView: RootView

    @InjectMockKs
    private lateinit var textViewRenderer: TextViewRenderer

    override fun setUp() {
        super.setUp()

        mockkStatic("br.com.zup.beagle.view.BeagleTextViewKt")

        every { textView.setTextWidget(any()) } just Runs
        every { text.style } returns DEFAULT_STYLE
        every { text.text } returns DEFAULT_TEXT
        every { rootView.getContext() } returns context
    }

    override fun tearDown() {
        super.tearDown()
        unmockkAll()
    }

    @Test
    fun build_should_return_a_TextView_instance_and_setTextWidget() {
        // Given
        every { viewFactory.makeTextView(context) } returns textView
        every { textView.setTextWidget(any()) } just Runs

        // When
        val view = textViewRenderer.build(rootView)

        // Then
        assertTrue(view is TextView)
        verify(exactly = 1) { textView.setTextWidget(text) }
    }
}
