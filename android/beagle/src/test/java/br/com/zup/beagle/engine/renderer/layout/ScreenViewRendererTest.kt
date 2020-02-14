package br.com.zup.beagle.engine.renderer.layout

import android.content.res.Resources
import android.content.res.TypedArray
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.view.Menu
import android.view.MenuItem
import android.view.View
import androidx.appcompat.app.ActionBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.content.res.ResourcesCompat
import br.com.zup.beagle.R
import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.ScreenComponent
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.spyk
import io.mockk.unmockkAll
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

private const val DEFAULT_COLOR = 0xFFFFFF

class ScreenViewRendererTest {

    @MockK
    private lateinit var screenComponent: ScreenComponent
    @MockK(relaxed = true)
    private lateinit var navigationBar: NavigationBar
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var context: AppCompatActivity
    @RelaxedMockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var component: ServerDrivenComponent
    @MockK
    private lateinit var viewRenderer: ViewRenderer<*>
    @RelaxedMockK
    private lateinit var view: View
    @MockK(relaxed = true)
    private lateinit var actionBar: ActionBar
    @RelaxedMockK
    private lateinit var toolbar: Toolbar
    @MockK
    private lateinit var action: Action
    @RelaxedMockK
    private lateinit var menu: Menu
    @MockK
    private lateinit var designSystemMock: DesignSystem
    @MockK
    private lateinit var typedArray: TypedArray
    @MockK
    private lateinit var navigationIcon: Drawable
    @MockK
    private lateinit var icon: Drawable
    @MockK
    private lateinit var resources: Resources

    private lateinit var screenViewRenderer: ScreenViewRenderer

    private val style = RandomData.string()
    private val styleInt = RandomData.int()
    private val titleTextAppearance = RandomData.int()
    private val backgroundColorInt = RandomData.int()

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Color::class)
        mockkObject(BeagleEnvironment)
        mockkStatic(ResourcesCompat::class)

        every { BeagleEnvironment.beagleSdk } returns mockk(relaxed = true)
        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addView(any()) } just Runs
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { screenComponent.navigationBar } returns null
        every { screenComponent.header } returns null
        every { screenComponent.content } returns component
        every { screenComponent.footer } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { Color.parseColor(any()) } returns DEFAULT_COLOR
        every { rootView.getContext() } returns context
        every {
            context.obtainStyledAttributes(styleInt, R.styleable.BeagleToolbarStyle)
        } returns typedArray
        every {
            typedArray.getDrawable(R.styleable.BeagleToolbarStyle_navigationIcon)
        } returns navigationIcon
        every {
            typedArray.getResourceId(R.styleable.BeagleToolbarStyle_titleTextAppearance, 0)
        } returns titleTextAppearance
        every {
            typedArray.getColor(R.styleable.BeagleToolbarStyle_android_background, 0)
        } returns backgroundColorInt
        every { typedArray.recycle() } just Runs
        every { context.resources } returns resources

        screenViewRenderer = ScreenViewRenderer(
            screenComponent,
            viewRendererFactory,
            viewFactory
        )
    }

    @After
    fun tearDown() {
        unmockkAll()
    }

    @Test
    fun build_should_create_a_screenWidget_with_flexDirection_COLUMN_and_justifyContent_SPACE_BETWEEN() {
        // Given
        val flexValues = mutableListOf<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flexValues)) } returns beagleFlexView
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)


        // Then
        assertEquals(FlexDirection.COLUMN, flexValues[0].flexDirection)
        assertEquals(JustifyContent.SPACE_BETWEEN, flexValues[0].justifyContent)
    }

    @Test
    fun build_should_call_header_builder_and_add_to_screenWidget_view() {
        // Given
        every { screenComponent.header } returns component
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { viewRendererFactory.make(component) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
    }

    @Test
    fun build_should_call_content_builder() {
        // Given
        val content = mockk<ServerDrivenComponent>()
        val flex = slot<Flex>()
        every { screenComponent.content } returns content
        every { beagleFlexView.addView(view, capture(flex)) } just Runs
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { beagleFlexView.addServerDrivenComponent(content)}
    }

    @Test
    fun build_should_call_footer_builder_and_add_to_screenWidget_view() {
        // Given
        every { screenComponent.footer } returns component
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { viewRendererFactory.make(component) }
        verify(atLeast = once()) { viewRenderer.build(rootView) }
        verify(atLeast = once()) { beagleFlexView.addView(view) }
    }

    @Test
    fun build_should_configure_toolbar_when_supportActionBar_is_not_null_and_toolbar_is_null() {
        // Given
        val title = RandomData.string()
        val showBackButton = true
        every { navigationBar.title } returns title
        every { navigationBar.showBackButton } returns showBackButton
        every { screenComponent.navigationBar } returns navigationBar
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { actionBar.title = title }
        verify(atLeast = once()) { actionBar.setDisplayHomeAsUpEnabled(showBackButton) }
        verify(atLeast = once()) { actionBar.setDisplayShowHomeEnabled(showBackButton) }
        verify(atLeast = once()) { actionBar.show() }
    }

    @Test
    fun build_should_configure_toolbar_when_supportActionBar_is_not_null_and_toolbar_is_not_null() {
        // Given
        every { screenComponent.navigationBar } returns navigationBar
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns toolbar

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { toolbar.visibility = View.VISIBLE }
    }

    @Test
    fun build_should_configure_toolbar_style_when_supportActionBar_is_not_null_and_toolbar_is_not_null() {
        // Given
        every { BeagleEnvironment.beagleSdk.designSystem } returns designSystemMock
        every { designSystemMock.toolbarStyle(style) } returns styleInt
        every { navigationBar.style } returns style
        every { screenComponent.navigationBar } returns navigationBar
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns toolbar

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { toolbar.navigationIcon = navigationIcon }
        verify(atLeast = once()) { toolbar.setTitleTextAppearance(context, titleTextAppearance) }
        verify(atLeast = once()) { toolbar.setBackgroundColor(backgroundColorInt) }
        verify(atLeast = once()) { typedArray.recycle() }
        verify(atLeast = once()) { toolbar.visibility = View.VISIBLE }
    }

    @Test
    fun build_should_configToolbarItems_when_navigationBarItems_is_not_null_and_image_is_null() {
        // GIVEN
        every { screenComponent.navigationBar } returns navigationBar
        every { context.supportActionBar } returns null
        every { context.findViewById<Toolbar>(any()) } returns toolbar
        every { toolbar.menu } returns menu
        val navigationBarItems = listOf(
            NavigationBarItem(text = "Stub", action = action)
        )
        every { navigationBar.navigationBarItems } returns navigationBarItems
        val menuItem = spyk<MenuItem>()
        every { menu.add(any(), any(), any(), any<String>()) } returns menuItem

        // WHEN
        screenViewRenderer.build(rootView)

        // THEN
        assertEquals(View.VISIBLE, toolbar.visibility)
        verify(exactly = once()) { menu.clear() }
        verify(exactly = navigationBarItems.size) { menu.add(Menu.NONE, 0, Menu.NONE, "Stub") }
        verify(exactly = navigationBarItems.size) { menuItem.setShowAsAction(MenuItem.SHOW_AS_ACTION_NEVER) }
    }

    @Test
    fun build_should_configToolbarItems_when_navigationBarItems_is_not_null_and_image_is_not_null() {
        // GIVEN
        every { BeagleEnvironment.beagleSdk.designSystem } returns designSystemMock
        every { designSystemMock.toolbarStyle(any()) } returns styleInt
        every { designSystemMock.image(any()) } returns RandomData.int()
        every { screenComponent.navigationBar } returns navigationBar
        every { context.supportActionBar } returns null
        every { context.findViewById<Toolbar>(any()) } returns toolbar
        every { toolbar.menu } returns menu
        val navigationBarItems = listOf(
            NavigationBarItem(text = "Stub", image = "image", action = action)
        )
        every { navigationBar.navigationBarItems } returns navigationBarItems
        val menuItem = spyk<MenuItem>()
        every { menu.add(any(), any(), any(), any<String>()) } returns menuItem
        every { ResourcesCompat.getDrawable(any(), any(), any()) } returns icon

        // WHEN
        screenViewRenderer.build(rootView)

        // THEN
        verify(exactly = once()) { menuItem.setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS) }
        verify(exactly = once()) { menuItem.icon = icon }
    }

    @Test
    fun build_should_hideNavigationBar_when_navigationBar_is_null() {
        // GIVEN
        every { context.supportActionBar } returns actionBar
        every { context.findViewById<Toolbar>(any()) } returns toolbar
        val expected = View.GONE
        every { toolbar.visibility = any() } just Runs
        every { toolbar.visibility } returns expected

        // WHEN
        screenViewRenderer.build(rootView)

        // THEN
        assertEquals(expected, toolbar.visibility)
        verify(atLeast = once()) { actionBar.hide() }
    }
}
