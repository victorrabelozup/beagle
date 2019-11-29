package br.com.zup.beagleui.framework.utils

import android.app.Activity
import android.os.IBinder
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.extensions.once
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
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
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
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var beagleView: BeagleView
    @MockK
    private lateinit var stateChangedListener: StateChangedListener
    @MockK(relaxed = true)
    private lateinit var inputMethodManager: InputMethodManager
    @MockK
    private lateinit var iBinder: IBinder

    private val viewSlot = slot<View>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        viewExtensionsViewFactory = viewFactory

        every { viewFactory.makeBeagleView(any()) } returns beagleView
        every { viewGroup.addView(capture(viewSlot)) } just Runs
        every { viewGroup.context } returns activity
        every { beagleView.loadView(any(), any()) } just Runs
        every { beagleView.windowToken } returns iBinder
        every { activity.getSystemService(Activity.INPUT_METHOD_SERVICE) } returns inputMethodManager
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_fragment() {
        viewGroup.loadView(fragment, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewExtensionsViewFactory.makeBeagleView(activity) }
        verify { beagleView.loadView(any(), URL) }
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_activity() {
        viewGroup.loadView(activity, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewExtensionsViewFactory.makeBeagleView(activity) }
        verify { beagleView.loadView(any(), URL) }
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

    @Test
    fun hideKeyboard_should_call_hideSoftInputFromWindow_with_currentFocus() {
        // Given
        every { activity.currentFocus } returns beagleView

        // When
        viewGroup.hideKeyboard()

        // Then
        verify(exactly = once()) { inputMethodManager.hideSoftInputFromWindow(iBinder, 0) }
    }

    @Test
    fun hideKeyboard_should_call_hideSoftInputFromWindow_with_created_view() {
        // Given
        every { activity.currentFocus } returns null
        every { viewExtensionsViewFactory.makeView(activity) } returns beagleView

        // When
        viewGroup.hideKeyboard()

        // Then
        verify(exactly = once()) { inputMethodManager.hideSoftInputFromWindow(iBinder, 0) }
    }
}