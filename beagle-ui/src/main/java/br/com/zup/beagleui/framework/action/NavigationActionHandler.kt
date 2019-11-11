package br.com.zup.beagleui.framework.action

import android.content.Context
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.BeagleNavigator

internal class NavigationActionHandler : ActionHandler<Navigate> {

    override fun handle(context: Context, action: Navigate) {
        when (action.type) {
            NavigationType.OPEN_DEEP_LINK -> openDeepLink(action, context)
            NavigationType.OPEN_VIEW -> openView(action, context)
            NavigationType.ADD_VIEW -> addView(action, context)
            NavigationType.FINISH_VIEW -> finishView(context)
            NavigationType.POP_VIEW -> popView(context)
        }
    }

    private fun openDeepLink(action: Navigate, context: Context) {
        action.path?.let { path ->
            BeagleEnvironment.beagleDeepLinkHandler?.getDeepLinkIntent(path, action.data)?.let { intent ->
                context.startActivity(intent)
            }
        }
    }

    private fun openView(action: Navigate, context: Context) {
        action.path?.let { path ->
            BeagleNavigator.openScreen(context, path)
        }
    }

    private fun addView(action: Navigate, context: Context) {
        action.path?.let { path ->
            BeagleNavigator.addScreen(context, path)
        }
    }

    private fun finishView(context: Context) {
        BeagleNavigator.finish(context)
    }

    private fun popView(context: Context) {
        BeagleNavigator.pop(context)
    }
}