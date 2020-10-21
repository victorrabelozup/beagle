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

package br.com.zup.beagle.android.context

import android.view.View
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.MutableLiveData
import br.com.zup.beagle.android.action.Action
import br.com.zup.beagle.android.action.AsyncAction
import br.com.zup.beagle.android.utils.generateViewModelInstance
import br.com.zup.beagle.android.view.viewmodel.ScreenContextViewModel
import br.com.zup.beagle.android.widget.RootView

class ContextActionExecutor {

    val asyncActionExecuted: MutableLiveData<AsyncActionData> = MutableLiveData()

    @Suppress("LongParameterList")
    fun executeActions(
        rootView: RootView,
        origin: View,
        sender: Any,
        actions: List<Action>,
        context: ContextData? = null
    ) {
        if (context != null) {
            createImplicitContextForActions(rootView, sender, context, actions)
        }

        actions.forEach {
            executeAction(rootView, origin, it)
        }
    }

    private fun createImplicitContextForActions(
        rootView: RootView,
        sender: Any,
        context: ContextData,
        actions: List<Action>
    ) {
        val viewModel = rootView.generateViewModelInstance<ScreenContextViewModel>()
        viewModel.addImplicitContext(context.normalize(), sender, actions)
    }

    fun executeAction(rootView: RootView, origin: View, action: Action) {
        if (action is AsyncAction) {
            asyncActionExecuted.value = AsyncActionData(origin, action)
            action.setActionStarted()
        }
        action.execute(rootView, origin)
    }
}

data class AsyncActionData(
    val origin: View,
    val asyncAction: AsyncAction
)
