package br.com.zup.beagleui.framework.state

import android.view.View
import android.widget.TextView
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.widget.layout.DynamicState
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

private const val HELLO_STRING = "Hello"

class StatefulRendererHelperTest {

    @InjectMockKs
    private lateinit var subject: StatefulRendererHelper

    @MockK
    private lateinit var statefulDynamicHelper: StatefulDynamicHelper

    @MockK
    private lateinit var statefulStaticHelper: StatefulStaticHelper

    private val widgetState = WidgetState(value = HELLO_STRING)

    private val childViewButton = mockk<View>(relaxUnitFun = true)
    private val childViewText = mockk<TextView>(relaxUnitFun = true)

    private val viewListDynamic = listOf(childViewButton, childViewText)
    private val viewListStatic = listOf(childViewButton, childViewText)
    private val updatableStateDynamic = UpdatableState(
        targetId = "txt1",
        dynamicState = DynamicState(
            originId = "btn1",
            stateOriginField = "value",
            targetField = "description"
        )
    )

    private val updatableStateStatic = UpdatableState(
        targetId = "txt1",
        staticState = Text("Any")
    )

    private var updatableWidgetButton: UpdatableWidget = UpdatableWidget(
        child = Button("Click to update"),
        id = "btn1",
        updateStates = listOf(
            updatableStateDynamic
        )
    )

    private var updatableWidgetText: UpdatableWidget = UpdatableWidget(
        child = Text("Default Text1", style = "DesignSystem.Text.H2"),
        id = "txt1"
    )

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)
    }

    @Test
    fun test_handleStateChange_should_call_handleDynamicState() {
        every { childViewButton.tag } returns updatableWidgetButton
        every { childViewText.tag } returns updatableWidgetText

        subject.handleStateChange(updatableStateDynamic, viewListDynamic, widgetState)

        verifyHandleState(isDynamic = true)
    }

    private fun verifyHandleState(isDynamic: Boolean) {
        verify(exactly = if(isDynamic) 1 else 0) { statefulDynamicHelper.handleDynamicState(any(), any(), any(), any()) }
        verify(exactly = if(isDynamic) 0 else 1) { statefulStaticHelper.notifyStaticState(any(), any()) }
    }

    @Test
    fun test_handleStateChange_should_call_notifyStaticState() {
        every { childViewButton.tag } returns updatableWidgetButton
        every { childViewText.tag } returns updatableWidgetText

        subject.handleStateChange(updatableStateStatic, viewListStatic)

        verifyHandleState(isDynamic = false)
    }
}