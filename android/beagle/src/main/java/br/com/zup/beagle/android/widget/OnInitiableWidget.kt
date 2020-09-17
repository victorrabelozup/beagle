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

package br.com.zup.beagle.android.widget

import android.view.View
import br.com.zup.beagle.android.action.Action
import br.com.zup.beagle.android.action.OnActionFinished

/**
 * Abstract class that has onInit property
 * @property onInit list of actions performed as soon as the component is rendered
 * @property onInitFinishedListener
 */
abstract class OnInitiableWidget : WidgetView() {

    abstract val onInit: List<Action>?

    @Transient
    private var onInitCalled = false

    @Transient
    private var onInitDone = false

    @Transient
    private var onInitFinishedListener: OnInitFinishedListener? = null

    fun handleOnInit(rootView: RootView, view: View) {
        onInit?.let {
            addListenerToExecuteOnInit(rootView, view)
        }
    }

    private fun addListenerToExecuteOnInit(rootView: RootView, view: View) {
        view.addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
            override fun onViewAttachedToWindow(v: View?) {
                if (!onInitCalled) {
                    executeOnInit(rootView, view)
                    onInitCalled = true
                }
            }
            override fun onViewDetachedFromWindow(v: View?) {}
        })
    }

    private fun executeOnInit(rootView: RootView, view: View) {
        val onInitActions = onInit?.toMutableList()
        onInit?.forEach { action ->
            action.execute(rootView, view, object : OnActionFinished {
                override fun onActionFinished(action: Action) {
                    onInitActions?.remove(action)
                    if (onInitActions?.isEmpty() == true) {
                        onInitDone = true
                        onInitFinishedListener?.invoke(view)
                    }
                }
            })
        }
    }

    fun setOnInitFinishedListener(view: View, listener: OnInitFinishedListener) {
        onInitFinishedListener = listener

        if (onInitDone) {
            onInitFinishedListener?.invoke(view)
        }
    }
}

/**
 *
 */
typealias OnInitFinishedListener = (view: View) -> Unit
