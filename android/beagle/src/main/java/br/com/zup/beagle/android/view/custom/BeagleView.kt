/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.android.view.custom

import android.annotation.SuppressLint
import android.view.View
import androidx.lifecycle.Observer
import br.com.zup.beagle.android.interfaces.OnStateUpdatable
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.utils.implementsGenericTypeOf
import br.com.zup.beagle.android.view.ScreenRequest
import br.com.zup.beagle.android.view.viewmodel.BeagleViewModel
import br.com.zup.beagle.android.view.viewmodel.ViewState
import br.com.zup.beagle.android.widget.RootView
import br.com.zup.beagle.core.ServerDrivenComponent

typealias OnStateChanged = (state: BeagleViewState) -> Unit

typealias OnLoadCompleted = () -> Unit

sealed class BeagleViewState {
    data class Error(val throwable: Throwable) : BeagleViewState()
    object LoadStarted : BeagleViewState()
    object LoadFinished : BeagleViewState()
}

@SuppressLint("ViewConstructor")
internal class BeagleView(
    private val rootView: RootView,
    private val viewModel: BeagleViewModel = rootView.generateViewModelInstance()
) : BeagleFlexView(rootView) {

    var stateChangedListener: OnStateChanged? = null

    var loadCompletedListener: OnLoadCompleted? = null

    fun loadView(screenRequest: ScreenRequest) {
        loadView(screenRequest, null)
    }

    fun updateView(url: String, view: View) {
        loadView(ScreenRequest(url), view)
    }

    private fun loadView(screenRequest: ScreenRequest, view: View?) {
        viewModel.fetchComponent(screenRequest).observe(rootView.getLifecycleOwner(), Observer { state ->
            handleResponse(state, view)
        })
    }

    private fun handleResponse(
        state: ViewState?, view: View?) {
        when (state) {
            is ViewState.Loading -> handleLoading(state.value)
            is ViewState.Error -> handleError(state.throwable)
            is ViewState.DoRender -> renderComponent(state.component, view)
        }
    }

    private fun handleLoading(isLoading: Boolean) {
        val state = if (isLoading) {
            BeagleViewState.LoadStarted
        } else {
            BeagleViewState.LoadFinished
        }
        stateChangedListener?.invoke(state)
    }

    private fun handleError(throwable: Throwable) {
        stateChangedListener?.invoke(BeagleViewState.Error(throwable))
    }

    private fun renderComponent(component: ServerDrivenComponent, view: View? = null) {
        if (view != null) {
            if (component.implementsGenericTypeOf(OnStateUpdatable::class.java, component::class.java)) {
                (component as? OnStateUpdatable<ServerDrivenComponent>)?.onUpdateState(component)
            } else {
                removeView(view)
                addServerDrivenComponent(component)
            }
        } else {
            removeAllViewsInLayout()
            addServerDrivenComponent(component)
            loadCompletedListener?.invoke()
        }
    }
}
