package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleNavigator

internal class NavigationActionHandler :
    ActionHandler<Navigate> {

    override fun handle(context: Context, action: Navigate) {
        when (action.type) {
            NavigationType.OPEN_DEEP_LINK -> openDeepLink(action, context)
            NavigationType.SWAP_VIEW -> swapView(action, context)
            NavigationType.ADD_VIEW -> addView(action, context)
            NavigationType.FINISH_VIEW -> finishView(context)
            NavigationType.POP_VIEW -> popView(context)
            NavigationType.POP_TO_VIEW -> popToView(action, context)
            NavigationType.PRESENT_VIEW -> presentView(action, context)
        }
    }

    private fun openDeepLink(action: Navigate, context: Context) {
        action.path?.let { path ->
            BeagleEnvironment.beagleSdk.deepLinkHandler?.getDeepLinkIntent(path, action.data)?.let { intent ->
                context.startActivity(intent)
            }
        }
    }

    private fun swapView(action: Navigate, context: Context) {
        BeagleNavigator.swapScreen(context = context, url = action.path, screen = action.screen)
    }

    private fun addView(action: Navigate, context: Context) {
        BeagleNavigator.addScreen(context = context, url = action.path, screen = action.screen)
    }

    private fun finishView(context: Context) {
        BeagleNavigator.finish(context)
    }

    private fun popView(context: Context) {
        BeagleNavigator.pop(context)
    }

    private fun popToView(action: Navigate, context: Context) {
        action.path?.let { path ->
            BeagleNavigator.popToScreen(context, path)
        }
    }

    private fun presentView(action: Navigate, context: Context) {
        BeagleNavigator.presentScreen(context = context, url = action.path, screen = action.screen)
    }
}