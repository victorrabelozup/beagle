/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.form.FormInputHidden
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.verify
import org.junit.Test

class FormInputHiddenViewRendererTest : BaseTest() {

    @RelaxedMockK
    private lateinit var formInputHidden: FormInputHidden
    @RelaxedMockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @RelaxedMockK
    private lateinit var viewFactory: ViewFactory
    @InjectMockKs
    private lateinit var formInputViewRenderer: FormInputHiddenViewRenderer

    @MockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var view: BeagleFlexView
    @RelaxedMockK
    private lateinit var context: Context

    override fun setUp() {
        super.setUp()

        every { viewRendererFactory.make(any()).build(any()) } returns view
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns view
        every { rootView.getContext() } returns context
    }

    @Test
    fun build_should_make_view_gone() {
        // WHEN
        formInputViewRenderer.build(rootView)

        // THEN
        verify(exactly = once()) { view.visibility = View.GONE }
        verify(exactly = once()) { view.tag = formInputHidden }
    }
}