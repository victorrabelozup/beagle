package br.com.zup.beagleui.framework.action

import android.content.Context
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.BeagleNavigator
import br.com.zup.beagleui.framework.widget.navigation.NavigatorData
import br.com.zup.beagleui.framework.widget.navigation.NavigatorEventType

internal class NavigationActionHandler : ActionHandler<Navigate> {

    override fun handle(context: Context, action: Navigate) {
        when (action.type) {
            NavigatorEventType.OPEN_DEEP_LINK -> openDeepLink(action.value, context)
            NavigatorEventType.OPEN_VIEW -> openView(action.value, context)
            NavigatorEventType.ADD_VIEW -> addView(action.value, context)
            NavigatorEventType.FINISH_VIEW -> finishView(context)
            NavigatorEventType.POP_VIEW -> popView(context)
        }
    }

    private fun openDeepLink(eventData: NavigatorData?, context: Context) {
        eventData?.let {
            BeagleEnvironment.beagleDeepLinkHandler?.getDeepLinkIntent(eventData)?.let {
                context.startActivity(it)
            }
        }
    }

    private fun openView(eventData: NavigatorData?, context: Context) {
        eventData?.let {
            BeagleNavigator.openScreen(context, eventData.path)
        }
    }

    private fun addView(eventData: NavigatorData?, context: Context) {
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