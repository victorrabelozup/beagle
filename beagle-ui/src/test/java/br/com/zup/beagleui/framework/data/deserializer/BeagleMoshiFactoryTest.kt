package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Padding
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.DropDown
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.Text
import br.com.zup.beagleui.framework.widget.ui.TextField
import br.com.zup.beagleui.framework.widget.ui.Toolbar
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleMoshiFactoryTest {

    private lateinit var beagleMoshiFactory: BeagleMoshiFactory

    @Before
    fun setUp() {
        beagleMoshiFactory = BeagleMoshiFactory()
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Container() {
        // Given
        val json = makeContainerJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Container)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_FlexWidget() {
        // Given
        val json = makeFlexWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is FlexWidget)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_FlexSingleWidget() {
        // Given
        val json = makeFlexSingleWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is FlexSingleWidget)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Vertical() {
        // Given
        val json = makeVerticalJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Vertical)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Horizontal() {
        // Given
        val json = makeHorizontalJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Horizontal)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Stack() {
        // Given
        val json = makeStackJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Stack)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Spacer() {
        // Given
        val json = makeSpacerJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Spacer)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Padding() {
        // Given
        val json = makePaddingJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Padding)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Text() {
        // Given
        val json = makeTextJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Text)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Image() {
        // Given
        val json = makeImageJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Image)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Button() {
        // Given
        val json = makeButtonJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Button)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_DropDown() {
        // Given
        val json = makeDropDownJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is DropDown)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_ListView() {
        // Given
        val json = makeListViewJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is ListView)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_TextField() {
        // Given
        val json = makeTextFieldJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is TextField)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Toolbar() {
        // Given
        val json = makeToolbarJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Toolbar)
    }
}