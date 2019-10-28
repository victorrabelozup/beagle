package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.BeagleNavigator
import br.com.zup.beagleui.framework.widget.navigation.DeeplinkURL
import br.com.zup.beagleui.framework.widget.navigation.Event
import br.com.zup.beagleui.framework.widget.navigation.EventType
import br.com.zup.beagleui.framework.widget.navigation.Navigator

internal class NavigatorViewRenderer(
    private val widget: Navigator,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(context: Context): View {
        return viewRendererFactory.make(widget.child).build(context).apply {
            setOnClickListener { handleButtonClick(widget.event, context) }
        }
    }

    private fun handleButtonClick(event: Event, context: Context) {
        when (event.type) {
            EventType.OPEN_DEEP_LINK -> openDeepLink(event.value, context)
            EventType.OPEN_VIEW -> openView(event.value, context)
            EventType.ADD_VIEW -> addView(event.value, context)
            EventType.FINISH_VIEW -> finishView(context)
            EventType.POP_VIEW -> popView(context)
        }
    }

    private fun openDeepLink(eventData: DeeplinkURL?, context: Context) {
        eventData?.let {
            BeagleEnvironment.beagleDeepLinkHandler?.getDeepLinkIntent(eventData)?.let {
                context.startActivity(it)
            }
        }
    }

    private fun openView(eventData: DeeplinkURL?, context: Context) {
        eventData?.let {
            BeagleNavigator.openScreen(context, eventData.path)
        }
    }

    private fun addView(eventData: DeeplinkURL?, context: Context) {
        eventData?.let {
            BeagleNavigator.addScreen(context, eventData.path)
        }
    }

    private fun finishView(context: Context) {
        BeagleNavigator.finish(context)
    }

    private fun popView(context: Context) {
        BeagleNavigator.pop(context)
    }
}
