package br.com.zup.beagle.utils

import android.content.Context
import android.content.res.TypedArray
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import android.view.View
import br.com.zup.beagle.R
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkAll
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class StyleManagerTest {

    @InjectMockKs
    private lateinit var styleManager: StyleManager

    @RelaxedMockK
    private lateinit var view: View
    @RelaxedMockK
    private lateinit var typedArray: TypedArray
    @RelaxedMockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var serverDrivenComponent: ServerDrivenComponent
    @RelaxedMockK
    private lateinit var designSystem: DesignSystem
    @RelaxedMockK
    private lateinit var colorDrawable: ColorDrawable
    @RelaxedMockK
    private lateinit var drawable: Drawable

    private var textAppearanceInt: Int = 0

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.beagleSdk.designSystem } returns mockk()
        every { view.background } returns mockk()
        every { designSystem.textAppearance(any()) } returns textAppearanceInt
        every { context.obtainStyledAttributes(any<Int>(), any()) } returns mockk()
        styleManager = StyleManager(designSystem)
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun test_getBackgroundColor_when_view_has_a_null_background() {
        //Given
        val expected = Color.TRANSPARENT
        every { view.background } returns null

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(expected, actual)
    }

    @Test
    fun test_getBackgroundColor_when_text_has_a_color_drawable_background() {
        //Given
        serverDrivenComponent = Text("")
        every { context.obtainStyledAttributes(any<Int>(), any()) } returns typedArray
        every { typedArray.getDrawable(R.styleable.BackgroundStyle_android_background) } returns colorDrawable
        every { colorDrawable.color } returns Color.WHITE

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //
        assertEquals(Color.WHITE, actual)
    }

    @Test
    fun test_getBackgroundColor_when_text_not_is_color_drawable() {
        //Given
        serverDrivenComponent = Text("")
        every { context.obtainStyledAttributes(any<Int>(), any()) } returns typedArray
        every { typedArray.getDrawable(R.styleable.BackgroundStyle_android_background) } returns drawable

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(null, actual)
    }

    @Test
    fun test_getBackgroundColor_when_button_has_a_color_drawable_background() {
        //Given
        serverDrivenComponent = Button("")
        every { context.obtainStyledAttributes(any<Int>(), any()) } returns typedArray
        every { typedArray.getDrawable(R.styleable.BackgroundStyle_android_background) } returns colorDrawable
        every { colorDrawable.color } returns Color.WHITE

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(Color.WHITE, actual)
    }

    @Test
    fun test_getBackgroundColor_when_Button_not_is_color_drawable() {
        //Given
        serverDrivenComponent = Button("")
        every { context.obtainStyledAttributes(any<Int>(), any()) } returns typedArray
        every { typedArray.getDrawable(R.styleable.BackgroundStyle_android_background) } returns drawable

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(null, actual)
    }

    @Test
    fun test_getBackgroundColor_when_view_has_a_color_drawable_background() {
        //Given
        serverDrivenComponent = Container(mockk())
        every { colorDrawable.color } returns Color.BLACK
        every { view.background } returns colorDrawable

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(Color.BLACK, actual)
    }

    @Test
    fun test_getBackgroundColor_when_view_has_not_a_color_drawable_background() {
        //Given
        serverDrivenComponent = Container(mockk())
        every { view.background } returns drawable

        //When
        val actual = styleManager.getBackgroundColor(
            context,
            serverDrivenComponent,
            view
        )

        //Then
        assertEquals(null, actual)
    }

}