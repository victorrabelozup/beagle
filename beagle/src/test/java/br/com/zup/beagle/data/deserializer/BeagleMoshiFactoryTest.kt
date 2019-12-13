package br.com.zup.beagle.data.deserializer

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.FormValidation
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.mockdata.CustomWidgetFactory
import br.com.zup.beagle.mockdata.CustomWidget
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.WidgetViewFactory
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.Horizontal
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.layout.Vertical
import br.com.zup.beagle.widget.lazy.LazyWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.PageIndicator
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Ignore
import org.junit.Test
import kotlin.test.assertNotNull
import kotlin.test.assertTrue

private const val APP_NAME = "sample"
@Suppress("UNCHECKED_CAST")
private val WIDGETS = mapOf(
    CustomWidget::class.java as Class<Widget> to CustomWidgetFactory() as WidgetViewFactory<Widget>
)

class BeagleMoshiFactoryTest {

    private lateinit var beagleMoshiFactory: BeagleMoshiFactory

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleMoshiFactory = BeagleMoshiFactory()

        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.appName } returns APP_NAME
        every { BeagleEnvironment.widgets } returns WIDGETS
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
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
    fun make_should_return_moshi_to_deserialize_a_NetworkImage() {
        // Given
        val json = makeNetworkImageJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is NetworkImage)
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
    fun make_should_return_moshi_to_deserialize_a_CustomWidget() {
        // Given
        val json = makeCustomWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is CustomWidget)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_LazyWidget() {
        // Given
        val json = makeLazyWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is LazyWidget)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_ScrollView() {
        // Given
        val json = makeScrollViewJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is ScrollView)
    }

    @Test
    @Ignore("Remove ignore when moshi is fixed")
    fun make_should_return_moshi_to_deserialize_a_PageView() {
        // Given
        val json = makePageViewWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is PageView)
    }

    @Test
    @Ignore("Remove ignore when moshi is fixed")
    fun make_should_return_moshi_to_deserialize_a_PageIndicator() {
        // Given
        val json = makePageIndicatorWidgetJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is PageIndicator)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_Navigate() {
        // Given
        val json = makeNavigationActionJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Action::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is Navigate)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_ShowNativeDialog() {
        // Given
        val json = makeShowNativeDialogJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Action::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is ShowNativeDialog)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_CustomAction() {
        // Given
        val json = makeCustomActionJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Action::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is CustomAction)
    }

    @Test
    fun make_should_return_moshi_to_deserialize_a_FormValidation() {
        // Given
        val json = makeFormValidationJson()

        // When
        val actual = beagleMoshiFactory.make().adapter(Action::class.java).fromJson(json)

        // Then
        assertNotNull(actual)
        assertTrue(actual is FormValidation)
    }
}