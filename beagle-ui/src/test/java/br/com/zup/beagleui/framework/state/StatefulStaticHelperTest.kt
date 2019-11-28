package br.com.zup.beagleui.framework.state

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.mockk
import org.junit.Test
import org.mockito.Mockito.spy
import org.mockito.Mockito.times
import org.mockito.Mockito.verify
import kotlin.test.fail

class StatefulStaticHelperTest {

    private var subject: StatefulStaticHelper = StatefulStaticHelper()

    private val updatableStateStatic = UpdatableState(
        targetId = "txt1",
        staticState = Text("Any")
    )

    private var context = mockk<Context>()
    private var view = spy(MyView(context))

    private open class MyView(context: Context): View(context), OnStateUpdatable<Widget>  {
            override fun onUpdateState(widget: Widget) {
            }
        }

    fun setup() {
        MockKAnnotations.init(this, relaxUnitFun = true)
    }

    @Test
    fun test_notifyStaticState_success() {
        subject.notifyStaticState(updatableStateStatic, view)
        updatableStateStatic.staticState?.let {
            verify(view as OnStateUpdatable<Widget>, times(1)).onUpdateState(it)
        }?:run {
            fail("staticState should be set")
        }
    }
}