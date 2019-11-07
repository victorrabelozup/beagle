package br.com.zup.beagleui.framework.utils

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.view.BeagleView
import br.com.zup.beagleui.framework.view.StateChangedListener
import br.com.zup.beagleui.framework.view.ViewFactory
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
import kotlin.test.assertFails

private val URL = RandomData.httpUrl()
private const val ERROR_MESSAGE = "Did you miss to call loadView()?"

class ViewExtensionsKtTest {

    @MockK
    private lateinit var viewGroup: ViewGroup
    @MockK
    private lateinit var fragment: Fragment
    @MockK
    private lateinit var activity: AppCompatActivity
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var beagleView: BeagleView
    @MockK
    private lateinit var stateChangedListener: StateChangedListener

    private val viewSlot = slot<View>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        viewExtensionsViewFactory = viewFactory

        every { viewFactory.makeBeagleView(any()) } returns beagleView
        every { viewGroup.addView(capture(viewSlot)) } just Runs
        every { viewGroup.context } returns context
        every { beagleView.loadView(any<Fragment>(), any()) } just Runs
        every { beagleView.loadView(any<AppCompatActivity>(), any()) } just Runs
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_fragment() {
        viewGroup.loadView(fragment, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewExtensionsViewFactory.makeBeagleView(context) }
        verify { beagleView.loadView(fragment, URL) }
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_activity() {
        viewGroup.loadView(activity, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewExtensionsViewFactory.makeBeagleView(context) }
        verify { beagleView.loadView(activity, URL) }
    }

    @Test
    fun setBeagleStateChangedListener_should_throws_exception_when_no_child_has_found() {
        // Given
        every { viewGroup.childCount } returns 0

        // When Then
        assertFails(ERROR_MESSAGE) { viewGroup.setBeagleStateChangedListener(stateChangedListener) }
    }

    @Test
    fun setBeagleStateChangedListener_should_throws_exception_when_no_BeagleView_has_found() {
        // Given
        every { viewGroup.childCount } returns 1
        every { viewGroup.getChildAt(any()) } returns mockk()

        // When Then
        assertFails(ERROR_MESSAGE) { viewGroup.setBeagleStateChangedListener(stateChangedListener) }
    }

    @Test
    fun setBeagleStateChangedListener_should_set_stateChangedListener_to_BeagleView() {
        // Given
        every { viewGroup.childCount } returns 1
        every { viewGroup.getChildAt(any()) } returns beagleView

        // When Then
        assertFails(ERROR_MESSAGE) { viewGroup.setBeagleStateChangedListener(stateChangedListener) }
    }
}