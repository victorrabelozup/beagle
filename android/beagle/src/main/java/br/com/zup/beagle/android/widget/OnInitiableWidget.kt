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

import android.util.Log
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

    fun handleOnInit() {
        onInit?.let {
            addListenerToExecuteOnInit()
        }
    }

    private fun addListenerToExecuteOnInit() {
        getView().addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
            override fun onViewAttachedToWindow(v: View?) {
                if (!onInitCalled) {
                    executeOnInit()
                    onInitCalled = true
                }
            }

            override fun onViewDetachedFromWindow(v: View?) {}
        })
    }

    fun executeOnInit() {
        val onInitActions = onInit?.toMutableList()
        onInitDone = false
        onInit?.forEach { action ->
            action.execute(getRootView(), getView(), object : OnActionFinished {
                override fun onActionFinished(action: Action) {
                    onInitActions?.remove(action)
                    if (onInitActions?.isEmpty() == true) {
                        onInitDone = true
                        onInitFinishedListener?.invoke(this@OnInitiableWidget)
                    }
                }
            })
        }
    }

    abstract fun getView(): View

    abstract fun getRootView(): RootView

    fun setOnInitFinishedListener(listener: OnInitFinishedListener) {
        onInitFinishedListener = listener

        if (onInitDone) {
            onInitFinishedListener?.invoke(this)
        }
    }
}

/**
 *
 */
typealias OnInitFinishedListener = (widget: OnInitiableWidget) -> Unit
