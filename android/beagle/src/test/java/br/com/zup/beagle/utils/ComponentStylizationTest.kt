package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class ComponentStylizationTest {

    @RelaxedMockK
    private lateinit var accessibilitySetup: AccessibilitySetup
    @RelaxedMockK
    private lateinit var view: View
    @RelaxedMockK
    private lateinit var widget: Text

    @InjectMockKs
    private lateinit var componentStylization: ComponentStylization<Text>

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
    }

    @Test
    fun afterBuildView_when_is_widget() {
        // GIVEN
        val widgetId = "123"
        val slotId = slot<Int>()

        every { widget.id } returns widgetId
        every { view.id = capture(slotId) } just Runs

        // WHEN
        componentStylization.apply(view, widget)

        // THEN
        assertEquals(widgetId.toAndroidId(), slotId.captured)
        verify (exactly = once()) { accessibilitySetup.applyAccessibility(view, widget) }
    }
}
