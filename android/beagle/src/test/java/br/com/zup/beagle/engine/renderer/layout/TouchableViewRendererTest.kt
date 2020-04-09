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
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.analytics.Analytics
import br.com.zup.beagle.analytics.ClickEvent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.data.PreFetchHelper
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.navigation.Touchable
import io.mockk.CapturingSlot
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.verify
import org.junit.Test
import kotlin.test.assertEquals

class TouchableViewRendererTest : BaseTest() {

    val touchableAction =  Navigate(NavigationType.ADD_VIEW)

    @MockK
    private lateinit var touchable: Touchable
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @RelaxedMockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var analytics: Analytics
    @RelaxedMockK
    private lateinit var view: BeagleFlexView
    @RelaxedMockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var actionExecutor: ActionExecutor
    @RelaxedMockK
    private lateinit var viewRenderer: ViewRenderer<ServerDrivenComponent>
    @RelaxedMockK
    private lateinit var preFetchHelper: PreFetchHelper

    private val onClickListenerSlot = slot<View.OnClickListener>()

    @InjectMockKs
    private lateinit var touchableViewRenderer: TouchableViewRenderer

    override fun setUp() {
        super.setUp()
        every { beagleSdk.analytics } returns analytics
        every { actionExecutor.doAction(any(), any()) } just Runs
        every { rootView.getContext() } returns context
        every { viewFactory.makeBeagleFlexView(any()) } returns view
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { view.setOnClickListener(capture(onClickListenerSlot)) } just Runs
        every { view.context } returns context
        every { touchable.action } returns touchableAction
        every { touchable.child } returns mockk(relaxed = true)
        every { touchable.clickAnalyticsEvent } returns null
    }

    @Test
    fun build_should_make_child_view() {
        val actual = touchableViewRenderer.build(rootView)

        assertEquals(view, actual)
    }

    @Test
    fun build_should_call_onClickListener() {
        // Given
        val navigateSlot = slot<Navigate>()
        every { actionExecutor.doAction(context, capture(navigateSlot)) } just Runs

        // When
        callBuildAndClick()

        // Then
        assertEquals(touchable.action, navigateSlot.captured)
    }

    private fun callBuildAndClick() {
        touchableViewRenderer.build(rootView)
        onClickListenerSlot.captured.onClick(view)
    }

    @Test
    fun should_call_analytics_when_button_clicked_and_click_event_presented() {
        // GIVEN
        val category = "category"
        val action = "action"
        val value = "value"
        val clickAnalyticsEvent = ClickEvent(
            category,
            action,
            value
        )
        every { touchable.clickAnalyticsEvent } returns clickAnalyticsEvent
        val onClickListenerSlot = CapturingSlot<View.OnClickListener>()

        // When
        val buttonView = touchableViewRenderer.build(rootView)
        verify { buttonView.setOnClickListener(capture(onClickListenerSlot)) }
        onClickListenerSlot.captured.onClick(view)

        // Then
        verify { analytics.sendClickEvent(eq(clickAnalyticsEvent)) }
    }

    @Test
    fun should_not_call_analytics_when_click_event_not_presented() {
        // GIVEN
        every { touchable.clickAnalyticsEvent } returns null
        val onClickListenerSlot = CapturingSlot<View.OnClickListener>()

        // When
        val buttonView = touchableViewRenderer.build(rootView)
        verify { buttonView.setOnClickListener(capture(onClickListenerSlot)) }
        onClickListenerSlot.captured.onClick(view)

        // Then
        verify(exactly = 0) { analytics.sendClickEvent(any()) }
    }
}
