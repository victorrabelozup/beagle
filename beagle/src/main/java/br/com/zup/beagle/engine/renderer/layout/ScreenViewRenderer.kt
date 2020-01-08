package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.R
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ScreenWidget
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.Expanded
import br.com.zup.beagle.widget.layout.NavigationBar

internal class ScreenViewRenderer(
    private val screenWidget: ScreenWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0,
            flexDirection = FlexDirection.COLUMN,
            justifyContent = JustifyContent.SPACE_BETWEEN
        )

        addToolbarIfNecessary(rootView.getContext(), screenWidget.navigationBar)

        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)

        this.screenWidget.header?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        val expanded = Expanded(this.screenWidget.content)
        val contentView = viewRendererFactory.make(expanded).build(rootView)
        container.addView(contentView)

        this.screenWidget.footer?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        return container
    }

    private fun addToolbarIfNecessary(context: Context, navigationBar: NavigationBar?) {
        if (navigationBar != null && context is AppCompatActivity) {
            context.supportActionBar?.apply {
                context.findViewById<Toolbar>(R.id.beagle_toolbar)?.let {
                    it.visibility = View.VISIBLE
                }
                title = navigationBar.title
                val showBackButton = navigationBar.showBackButton ?: true
                setDisplayHomeAsUpEnabled(showBackButton)
                setDisplayShowHomeEnabled(showBackButton)
                show()
            }
        }
    }
}
