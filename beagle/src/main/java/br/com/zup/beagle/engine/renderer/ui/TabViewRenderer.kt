package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.content.res.Resources
import android.graphics.drawable.Drawable
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.viewpager.widget.PagerAdapter
import androidx.viewpager.widget.ViewPager
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.utils.dp
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import com.google.android.material.tabs.TabLayout

private val TABBAR_HEIGHT = 48.dp()
private val DEFTYPE_DRAWABLE = "drawable"

internal class TabViewRenderer(
    override val widget: TabView,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<TabView>() {

    override fun buildView(rootView: RootView): View {
        val containerFlex = Flex(flexDirection = FlexDirection.COLUMN, grow = 1.0)

        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), containerFlex)

        val tabLayout = makeTabLayout(rootView.getContext())

        val viewPager = viewFactory.makeViewPager(rootView.getContext()).apply {
            adapter = ContentAdapter(rootView = rootView, tabList = widget.tabItems)
        }

        tabLayout.addOnTabSelectedListener(getTabSelectedListener(viewPager))
        viewPager.addOnPageChangeListener(getViewPagerChangePageListener(tabLayout))

        container.addView(tabLayout)
        container.addView(viewPager)
        return container
    }

    private fun makeTabLayout(context: Context): TabLayout {
        return viewFactory.makeTabView(context).apply {
            layoutParams =
                viewFactory.makeFrameLayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    TABBAR_HEIGHT
                )
            tabMode = TabLayout.MODE_SCROLLABLE
            addTabs(context)
        }
    }

    private fun TabLayout.addTabs(context: Context) {
        for (i in widget.tabItems.indices) {
            addTab(newTab().apply {
                text = widget.tabItems[i].title
                widget.tabItems[i].icon?.let {
                    try {
                        icon = getIconFromResources(context, it)
                    } catch (e: Resources.NotFoundException) {
                        BeagleMessageLogs.logIconResourceNotFound(it, e)
                    }
                }
            })
        }
    }

    private fun getIconFromResources(context: Context, icon: String): Drawable {
        return context.resources.getDrawable(
            context.resources.getIdentifier(icon, DEFTYPE_DRAWABLE, context.packageName)
        )
    }

    private fun getTabSelectedListener(viewPager: ViewPager): TabLayout.OnTabSelectedListener {
        return object :
            TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                viewPager.currentItem = tab.position
            }

            override fun onTabUnselected(tab: TabLayout.Tab) {}

            override fun onTabReselected(tab: TabLayout.Tab) {}
        }
    }

    private fun getViewPagerChangePageListener(tabLayout: TabLayout): ViewPager.OnPageChangeListener {
        return object : ViewPager.OnPageChangeListener {
            override fun onPageScrollStateChanged(state: Int) {}

            override fun onPageScrolled(
                position: Int,
                positionOffset: Float,
                positionOffsetPixels: Int
            ) {
            }

            override fun onPageSelected(position: Int) {
                val tab = tabLayout.getTabAt(position)
                tab?.select()
            }

        }
    }
}

internal class ContentAdapter(
    private val tabList: List<TabItem>,
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    private val rootView: RootView
) : PagerAdapter() {
    override fun isViewFromObject(view: View, `object`: Any): Boolean = view === `object`

    override fun getCount(): Int = tabList.size

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        val view = viewRendererFactory.make(tabList[position].content).build(rootView)
        container.addView(view)
        return view
    }

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        container.removeView(`object` as View)
    }
}