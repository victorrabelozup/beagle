package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.utils.ToolbarManager
import br.com.zup.beagle.utils.configureSupportActionBar
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.ScreenComponent

internal class ScreenViewRenderer(
    override val component: ScreenComponent,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    private val toolbarManager: ToolbarManager = ToolbarManager()
) : LayoutViewRenderer<ScreenComponent>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0,
            justifyContent = JustifyContent.SPACE_BETWEEN
        )

        addNavigationBarIfNecessary(rootView.getContext(), component.navigationBar)

        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)

        container.addServerDrivenComponent(component.child, rootView)

        return container
    }

    private fun addNavigationBarIfNecessary(context: Context, navigationBar: NavigationBar?) {
        if (context is BeagleActivity) {
            if (navigationBar != null) {
                configNavigationBar(context, navigationBar)
            } else {
                hideNavigationBar(context)
            }
        }
    }

    private fun hideNavigationBar(context: BeagleActivity) {
        context.supportActionBar?.apply {
            hide()
        }

        context.getToolbar().visibility = View.GONE
    }

    private fun configNavigationBar(
        context: BeagleActivity,
        navigationBar: NavigationBar
    ) {
        context.configureSupportActionBar()
        toolbarManager.configureNavigationBarForScreen(context, navigationBar)
        toolbarManager.configureToolbar(context, navigationBar)
    }

}
