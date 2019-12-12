package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.extensions.once
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.DynamicState
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

private const val STR_VALUE = "Value"

class StatefulDynamicHelperTest {

    private val subject: StatefulDynamicHelper = StatefulDynamicHelper()

    private val widgetState = WidgetState(value = STR_VALUE)

    private val dinamicState = UpdatableState(
        targetId = "txt3",
        dynamicState = DynamicState(
            originId = "txt1",
            stateOriginField = "value",
            targetField = "text"
        )
    )

    private var updatableWidgetButton: UpdatableWidget = UpdatableWidget(
        id = "txt1",
        child = Button("Click to update"),
        updateStates = listOf(
            dinamicState
        )
    )

    private var updatableWidgetText: UpdatableWidget = UpdatableWidget(
        child = Text("Default Text1", style = "DesignSystem.Text.H2"),
        id = "txt3"
    )

    private val observable: Observable<WidgetState> = Observable<WidgetState>()
        .apply {
            notifyObservers(widgetState)
        }

    private val childViewButton = mockk<View>(
        relaxUnitFun = true,
        moreInterfaces = *arrayOf(OnStateUpdatable::class, StateChangeable::class)
    )

    private val childViewText =
        mockk<View>(
            relaxUnitFun = true,
            moreInterfaces = *arrayOf(OnStateUpdatable::class, StateChangeable::class)
        )

    private val viewList = listOf(childViewButton, childViewText)

    @Before
    fun setup() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        every { (childViewButton as StateChangeable).getState() } returns observable
        every { (childViewText as StateChangeable).getState() } returns observable
        every { childViewButton.tag } returns updatableWidgetButton
        every { childViewText.tag } returns updatableWidgetText

    }

    @Test
    @Suppress("UNCHECKED_CAST")
    fun test_handleDynamicState_success() {
        subject.handleDynamicState(
            targetView = childViewText, updatableState = dinamicState,
            widgetState = widgetState, children = viewList
        )

        verify(exactly = once()) { (childViewText as? OnStateUpdatable<Widget>)?.onUpdateState(any()) }
    }

}