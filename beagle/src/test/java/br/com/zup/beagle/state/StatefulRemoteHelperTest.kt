package br.com.zup.beagle.state

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.interfaces.StateChangeable
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.view.BeagleView
import br.com.zup.beagle.widget.layout.RemoteState
import br.com.zup.beagle.widget.layout.RemoteUpdatableWidget
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class StatefulRemoteHelperTest {
    private val strValue = RandomData.string()
    private val widgetUrl = "http://www.mocky.io/v2/#{btn1.value}"
    private val widgetUrlWithValue = "http://www.mocky.io/v2/$strValue"

    private val subject: StatefulRemoteHelper = StatefulRemoteHelper()
    @MockK
    private lateinit var rootView: RootView

    private val widgetState = WidgetState(value = strValue)

    private val observable: Observable<WidgetState> = Observable<WidgetState>()
        .apply {
            notifyObservers(widgetState)
        }

    private val originView = mockk<View>(
        relaxUnitFun = true,
        moreInterfaces = *arrayOf(OnStateUpdatable::class, StateChangeable::class)
    )

    private val targetView =
        mockk<BeagleView>(
            relaxUnitFun = true
        )

    private val viewList = listOf(originView, targetView)

    private val remoteState = UpdatableState(
        targetId = "txt3",
        remoteState = RemoteState()
    )

    private var updatableWidgetButton: UpdatableWidget = UpdatableWidget(
        child = Button("Click to update"),
        id = "btn1",
        updateStates = listOf(
            remoteState
        )
    )

    private var updatableWidgetText: UpdatableWidget = UpdatableWidget(
        child = RemoteUpdatableWidget(
            url = widgetUrl,
            initialState = Text(text = "Select..")
        ),
        id = "txt3"
    )


    private val context = mockk<Context>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)
        every { rootView.getContext() } returns context

        every { (originView as StateChangeable).getState() } returns observable
        every { originView.tag } returns updatableWidgetButton
        every { targetView.tag } returns updatableWidgetText

    }

    @Test
    fun test_handleRemoteState_success() {
        subject.handleRemoteState(
            targetView = targetView, updatableState = remoteState,
            children = viewList, rootView = rootView
        )

        verify(exactly = once()) {
            (targetView as? BeagleView)?.loadView(
                rootView,
                widgetUrlWithValue
            )
        }
    }

}