package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.widget.FrameLayout
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.BeaglePageView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import com.google.android.material.tabs.TabLayout
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.runs
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class TabViewRendererTest {

    @InjectMockKs
    private lateinit var tabViewRenderer: TabViewRenderer

    @MockK
    private lateinit var rootView: RootView
    @MockK(relaxed = true)
    private lateinit var context: Context
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK(relaxed = true)
    private lateinit var tabLayout: TabLayout
    @MockK
    private lateinit var viewPager: BeaglePageView
    @MockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var tabView: TabView
    @MockK
    private lateinit var frameLayoutParams: FrameLayout.LayoutParams
    @MockK(relaxed = true)
    private lateinit var tabItem: TabItem

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.application } returns mockk {
            every { resources.displayMetrics } returns mockk() {
                density = 10f
            }
        }

        every { rootView.getContext() } returns context

        every { viewFactory.makeBeagleFlexView(context, any()) } returns beagleFlexView
        every { viewFactory.makeViewPager(context) } returns viewPager
        every { viewFactory.makeTabView(context) } returns tabLayout
        every { viewFactory.makeFrameLayoutParams(any(), any()) } returns frameLayoutParams

        every { viewPager.setAdapter(any()) } just runs
        every { viewPager.addOnPageChangeListener(any()) } just runs

        every { beagleFlexView.addView(any()) } just runs

        every { tabView.tabItems } returns listOf(tabItem)
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun build_should_return_view_with_tablayout_and_viewpager() {
        // When
        val view = tabViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { beagleFlexView.addView(tabLayout) }
        verify(exactly = once()) { beagleFlexView.addView(viewPager) }
    }

    @Test
    fun build_should_add_listeners_to_tablayout_and_viewpager() {
        // When
        val view = tabViewRenderer.build(rootView)

        // Then
        verify(exactly = once()) { tabLayout.addOnTabSelectedListener(any()) }
        verify(exactly = once()) { viewPager.addOnPageChangeListener(any()) }
    }

    @Test
    fun build_should_add_tabs() {
        // When
        val view = tabViewRenderer.build(rootView)

        // Then
        verify { tabLayout.addTab(any()) }
    }
}