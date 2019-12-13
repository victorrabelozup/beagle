package br.com.zup.beagle.state

import android.view.View
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.fail

class StatefulStaticHelperTest {

    private var subject: StatefulStaticHelper = StatefulStaticHelper()

    @MockK
    private lateinit var updatableStateStatic: UpdatableState

    @MockK
    private lateinit var text: Text

    private var view = mockk<View>(
        relaxUnitFun = true, moreInterfaces = *arrayOf(
            OnStateUpdatable::class
        )
    )

    @Before
    fun setup() {
        MockKAnnotations.init(this, relaxUnitFun = true)
        every { updatableStateStatic.staticState } returns text
    }

    @Suppress("UNCHECKED_CAST")
    @Test
    fun test_notifyStaticState_success() {
        subject.notifyStaticState(updatableStateStatic, view)
        updatableStateStatic.staticState?.let {
            verify(exactly = 1) {
                (view as? OnStateUpdatable<Widget>)?.onUpdateState(
                    any()
                )
            }

        } ?: run {
            fail("staticState should be set")
        }
    }
}