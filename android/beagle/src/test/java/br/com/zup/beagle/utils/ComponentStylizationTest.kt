package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.ui.Text
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.Test
import kotlin.test.assertEquals

class ComponentStylizationTest : BaseTest() {

    @RelaxedMockK
    private lateinit var accessibilitySetup: AccessibilitySetup
    @RelaxedMockK
    private lateinit var view: View
    @RelaxedMockK
    private lateinit var widget: Text
    @RelaxedMockK
    private lateinit var styleManager: StyleManager

    @InjectMockKs
    private lateinit var componentStylization: ComponentStylization<Text>

    override fun setUp() {
        super.setUp()
        styleManagerFactory = styleManager
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
