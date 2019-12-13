package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import android.view.ViewGroup
import androidx.viewpager.widget.PagerAdapter
import androidx.viewpager.widget.ViewPager
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeaglePageView
import br.com.zup.beagle.view.PageIndicatorInput
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.PageView

internal class PageViewRenderer(
    private val widget: PageView,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val containerFlex = Flex(
            flexDirection = FlexDirection.COLUMN,
            grow = 1.0
        )
        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), containerFlex)

        val viewPager = viewFactory.makeViewPager(rootView.getContext()).apply {
            adapter = PageViewAdapter(rootView, widget.pages)
        }

        val pageIndicatorFlex = Flex(
            flexDirection = FlexDirection.COLUMN
        )
        val containerViewPager =
            viewFactory.makeBeagleFlexView(rootView.getContext(), pageIndicatorFlex).apply {
                addView(viewPager)
            }
        container.addView(containerViewPager)

        widget.pageIndicator?.let {
            val pageIndicator = viewRendererFactory.make(it).build(rootView)
            setupPageIndicator(widget.pages.size, viewPager, pageIndicator as PageIndicatorInput)
            container.addView(pageIndicator)
        }

        return container
    }

    private fun setupPageIndicator(
        pages: Int,
        viewPager: BeaglePageView,
        pageIndicator: PageIndicatorInput
    ) {
        pageIndicator.initPageView(viewPager)
        pageIndicator.setCount(pages)
        viewPager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener {
            override fun onPageScrollStateChanged(state: Int) {}

            override fun onPageScrolled(
                position: Int,
                positionOffset: Float,
                positionOffsetPixels: Int
            ) {}

            override fun onPageSelected(position: Int) {
                pageIndicator.onItemUpdated(position)
            }
        })
    }
}

internal class PageViewAdapter(
    private val rootView: RootView,
    private val pages: List<Widget>,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : PagerAdapter() {

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        val view = viewRendererFactory.make(pages[position]).build(rootView)
        container.addView(view)
        return view
    }

    override fun isViewFromObject(view: View, `object`: Any): Boolean = view === `object`

    override fun getCount(): Int = pages.size

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        container.removeView(`object` as View)
    }
}
