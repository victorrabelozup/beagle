package br.com.zup.beagle.data

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.utils.generateViewModelInstance

internal class PreFetchHelper {

    fun handlePreFetchWidget(rootView: RootView, action: Action) {
        if (action is Navigate) {
            when (action.type) {
                NavigationType.SWAP_VIEW -> preFetchWidget(rootView, action)
                NavigationType.ADD_VIEW -> preFetchWidget(rootView, action)
                NavigationType.PRESENT_VIEW -> preFetchWidget(rootView, action)
                else -> {}
            }
        }
    }

    private fun preFetchWidget(rootView: RootView, action: Navigate) {
        val viewModel = rootView.generateViewModelInstance()
        action.href?.let {
            viewModel.fetchWidgetForCache(it)
        }
    }
}