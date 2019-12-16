package br.com.zup.beagle.utils

import android.app.Activity
import android.os.IBinder
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.TextViewCompat
import androidx.fragment.app.Fragment
import br.com.zup.beagle.engine.mapper.ViewMapper
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.ButtonStyle
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.view.BeagleButtonView
import br.com.zup.beagle.view.BeagleTextView
import br.com.zup.beagle.view.BeagleView
import br.com.zup.beagle.view.StateChangedListener
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import kotlin.test.assertFails

private val URL = RandomData.httpUrl()
private val STYLE_RES = RandomData.int()
private val IMAGE_RES = RandomData.int()
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
    @MockK
    private lateinit var designSystem: DesignSystem
    @MockK
    private lateinit var beagleTextView: BeagleTextView
    @MockK
    private lateinit var beagleButton: BeagleButtonView
    @MockK
    private lateinit var buttonStyle: ButtonStyle
    @MockK
    private lateinit var imageView: ImageView
    @MockK
    private lateinit var viewMapper: ViewMapper

    private val textValueSlot = slot<String>()
    private val viewSlot = slot<View>()
    private val textAlignment = slot<Int>()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        mockkStatic(TextViewCompat::class)

        viewExtensionsViewFactory = viewFactory

        every { viewFactory.makeBeagleView(any()) } returns beagleView
        every { viewFactory.makeView(any()) } returns beagleView
        every { viewGroup.addView(capture(viewSlot)) } just Runs
        every { viewGroup.context } returns activity
        every { beagleView.loadView(any(), any()) } just Runs
        every { beagleView.windowToken } returns iBinder
        every { activity.getSystemService(Activity.INPUT_METHOD_SERVICE) } returns inputMethodManager
        every { BeagleEnvironment.designSystem } returns designSystem
        every { designSystem.textAppearance(any()) } returns STYLE_RES
        every { designSystem.buttonStyle(any()) } returns buttonStyle
        every { designSystem.image(any()) } returns IMAGE_RES
        every { beagleTextView.text = capture(textValueSlot) } just Runs
        every { beagleTextView.gravity = capture(textAlignment) } just Runs
        every { beagleButton.text = capture(textValueSlot) } just Runs
        every { beagleButton.setBackgroundResource(any()) } just Runs
        every { buttonStyle.background } returns STYLE_RES
        every { buttonStyle.textAppearance } returns STYLE_RES
        every { TextViewCompat.setTextAppearance(any(), any()) } just Runs
        every { imageView.scaleType = any() } just Runs
        every { imageView.setImageResource(any()) } just Runs
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_fragment() {
        viewGroup.loadView(fragment, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewFactory.makeBeagleView(activity) }
        verify { beagleView.loadView(any<FragmentRootView>(), URL) }
    }

    @Test
    fun loadView_should_create_BeagleView_and_call_loadView_with_activity() {
        viewGroup.loadView(activity, URL)

        assertEquals(beagleView, viewSlot.captured)
        verify { viewFactory.makeBeagleView(activity) }
        verify { beagleView.loadView(any<ActivityRootView>(), URL) }
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

    @Test
    fun setData_with_text_should_call_TextViewCompat_setTextAppearance() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        val style = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns style
        every { text.alignment } returns null

        // When
        beagleTextView.setData(text)

        // Then
        assertEquals(textValue, textValueSlot.captured)
        verify(exactly = 1) { TextViewCompat.setTextAppearance(beagleTextView, STYLE_RES) }
    }

    @Test
    fun setData_with_text_should_not_call_TextViewCompat_setTextAppearance_when_style_is_null() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns null
        every { text.alignment } returns null

        // When
        beagleTextView.setData(text)

        // Then
        verify(exactly = 1) { designSystem.textAppearance("") }
    }

    @Test
    fun setData_with_text_should_set_alignment_when_is_center() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns null
        every { text.alignment } returns TextAlignment.CENTER

        // When
        beagleTextView.setData(text)

        // Then
        assertEquals(Gravity.CENTER, textAlignment.captured)
    }

    @Test
    fun setData_with_text_should_set_alignment_when_is_right() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns null
        every { text.alignment } returns TextAlignment.RIGHT

        // When
        beagleTextView.setData(text)

        // Then
        assertEquals(Gravity.END, textAlignment.captured)
    }

    @Test
    fun setData_with_text_should_set_alignment_when_is_left() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns null
        every { text.alignment } returns TextAlignment.LEFT

        // When
        beagleTextView.setData(text)

        // Then
        assertEquals(Gravity.START, textAlignment.captured)
    }

    @Test
    fun setData_with_text_should_not_call_TextViewCompat_setTextAppearance_when_designSystem_is_null() {
        // Given
        val text = mockk<Text>()
        val textValue = RandomData.string()
        every { text.text } returns textValue
        every { text.style } returns RandomData.string()
        every { BeagleEnvironment.designSystem } returns null
        every { text.alignment } returns null

        // When
        beagleTextView.setData(text)

        // Then
        verify(exactly = 0) { TextViewCompat.setTextAppearance(beagleTextView, STYLE_RES) }
    }

    @Test
    fun setData_with_button_should_call_TextViewCompat_setTextAppearance() {
        // Given
        val button = mockk<Button>()
        val textValue = RandomData.string()
        val style = RandomData.string()
        every { button.text } returns textValue
        every { button.style } returns style

        // When
        beagleButton.setData(button)

        // Then
        assertEquals(textValue, textValueSlot.captured)
        verify(exactly = 1) { beagleButton.setBackgroundResource(STYLE_RES) }
        verify(exactly = 1) { TextViewCompat.setTextAppearance(beagleButton, STYLE_RES) }
    }

    @Test
    fun setData_with_button_should_not_call_TextViewCompat_setTextAppearance_when_style_is_null() {
        // Given
        val button = mockk<Button>()
        val textValue = RandomData.string()
        every { button.text } returns textValue
        every { button.style } returns null

        // When
        beagleButton.setData(button)

        // Then
        verify(exactly = 1) { designSystem.buttonStyle("") }
    }

    @Test
    fun setData_with_button_should_not_call_TextViewCompat_setTextAppearance_when_designSystem_is_null() {
        // Given
        val button = mockk<Button>()
        val textValue = RandomData.string()
        every { button.text } returns textValue
        every { button.style } returns RandomData.string()
        every { BeagleEnvironment.designSystem } returns null

        // When
        beagleButton.setData(button)

        // Then
        verify(exactly = 0) { TextViewCompat.setTextAppearance(beagleButton, STYLE_RES) }
    }

    @Test
    fun setData_with_image_should_set_fit_center_when_content_mode_is_null_and_design_system_is_not_null() {
        // Given
        val image = mockk<Image>()
        val scaleTypeSlot = slot<ImageView.ScaleType>()
        val scaleType = ImageView.ScaleType.FIT_CENTER
        every { image.contentMode } returns null
        every { image.name } returns "imageName"
        every { viewMapper.toScaleType(any()) } returns scaleType
        every { imageView.scaleType = capture(scaleTypeSlot) } just Runs

        // When
        imageView.setData(image, viewMapper)

        // Then
        assertEquals(scaleType, scaleTypeSlot.captured)
        verify(exactly = 1) { imageView.setImageResource(IMAGE_RES) }
    }

    @Test
    fun setData_with_image_should_set_desired_scaleType_and_design_system_is_null() {
        // Given
        val image = mockk<Image>()
        val scaleTypeSlot = slot<ImageView.ScaleType>()
        val scaleType = ImageView.ScaleType.CENTER_CROP
        every { image.contentMode } returns ImageContentMode.CENTER_CROP
        every { viewMapper.toScaleType(any()) } returns scaleType
        every { BeagleEnvironment.designSystem } returns null
        every { imageView.scaleType = capture(scaleTypeSlot) } just Runs

        // When
        imageView.setData(image, viewMapper)

        // Then
        assertEquals(scaleType, scaleTypeSlot.captured)
        verify(exactly = 0) { imageView.setImageResource(IMAGE_RES) }
    }
}
