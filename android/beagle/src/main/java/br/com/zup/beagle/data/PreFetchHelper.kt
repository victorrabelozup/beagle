package br.com.zup.beagle.data

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.utils.generateViewModelInstance

internal class PreFetchHelper {

    fun handlePreFetch(rootView: RootView, action: Action) {
        if (action is Navigate && action.shouldPrefetch) {
            when (action.type) {
                NavigationType.SWAP_VIEW -> preFetch(rootView, action)
                NavigationType.ADD_VIEW -> preFetch(rootView, action)
                NavigationType.PRESENT_VIEW -> preFetch(rootView, action)
                else -> {}
            }
        }
    }

    private fun preFetch(rootView: RootView, action: Navigate) {
        val viewModel = rootView.generateViewModelInstance()
        action.path?.let {
            viewModel.fetchForCache(it)
        }
    }
}