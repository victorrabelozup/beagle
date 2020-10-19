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
import br.com.zup.beagle.android.action.AsyncAction
import br.com.zup.beagle.android.action.OnActionFinished

/**
 * Listener that informs that the widget has finished executing all onInit actions
 */
typealias OnInitFinishedListener = (widget: OnInitiableWidget) -> Unit

/**
 * Abstract class that has onInit property
 * @property onInit list of actions performed as soon as the component is rendered
 * @property onInitCalled tells whether onInit has already been called
 * @property onInitDone tell if onInit is finished
 * @property onInitFinishedListener invoked the moment the onInit ended
 */
abstract class OnInitiableWidget : WidgetView() {

    abstract val onInit: List<Action>?

    @Transient
    private var onInitCalled = false

    @Transient
    private var onInitDone = false

    @Transient
    private var onInitFinishedListener: OnInitFinishedListener? = null

    @Transient
    private lateinit var rootView: RootView

    @Transient
    private lateinit var origin: View

    /**
     * Method responsible for executing all actions present in the onInit property once the component is rendered.
     * It is recommended to call this method within the buildView.
     * @property rootView from buildView
     * @property origin view that triggered the action
     */
    fun handleOnInit(rootView: RootView, origin: View) {
        this.rootView = rootView
        this.origin = origin
        onInit?.let {
            addListenerToExecuteOnInit()
        }
    }

    private fun addListenerToExecuteOnInit() {
        origin.addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
            override fun onViewAttachedToWindow(v: View?) {
                if (!onInitCalled) {
                    executeOnInit()
                    onInitCalled = true
                }
            }

            override fun onViewDetachedFromWindow(v: View?) {}
        })
    }

    /**
     * Method responsible for executing all actions present in the onInit property
     * regardless of whether they have already been executed.
     */
    fun executeOnInit() {
        val onInitActions = onInit?.toMutableList()
        onInitDone = false
        onInit?.forEach { action ->
            action.execute(rootView, origin)
            if (action is AsyncAction) {
                action.listener = object : OnActionFinished {
                    override fun onActionFinished(action: Action) {
                        checkIfActionsDone(onInitActions, action)
                    }
                }
            } else {
                checkIfActionsDone(onInitActions, action)
            }
        }
    }

    private fun checkIfActionsDone(onInitActions: MutableList<Action>?, action: Action) {
        onInitActions?.remove(action)
        if (onInitActions?.isEmpty() == true) {
            onInitDone = true
            onInitFinishedListener?.invoke(this@OnInitiableWidget)
        }
    }

    /**
     * Method responsible for adding a listener for the execution of the actions present in the onInit property.
     */
    fun setOnInitFinishedListener(listener: OnInitFinishedListener) {
        onInitFinishedListener = listener

        if (onInitDone) {
            onInitFinishedListener?.invoke(this)
        }
    }
}
