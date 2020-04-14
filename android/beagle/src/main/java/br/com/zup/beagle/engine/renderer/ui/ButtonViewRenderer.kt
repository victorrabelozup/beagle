/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import androidx.core.widget.TextViewCompat
import br.com.zup.beagle.R
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleButtonView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.Button

internal class ButtonViewRenderer(
    override val component: Button,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val actionExecutor: ActionExecutor = ActionExecutor()
) : UIViewRenderer<Button>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeButton(rootView.getContext()).apply {
            setOnClickListener {
                actionExecutor.doAction(context, component.action)
                component.clickAnalyticsEvent?.let {
                    BeagleEnvironment.beagleSdk.analytics?.
                    sendClickEvent(it)
                }
            }
            setData(component)
        }
    }
}

internal fun BeagleButtonView.setData(component: Button) {
    val typedArray = styleManagerFactory.getButtonTypedArray(context, component.style)
    typedArray?.let {
        background = it.getDrawable(R.styleable.BeagleButtonStyle_background)
        isAllCaps = it.getBoolean(R.styleable.BeagleButtonStyle_textAllCaps, true)
        it.recycle()
    }
    styleManagerFactory.getButtonStyle(component.style)?.let { buttonStyle ->
        TextViewCompat.setTextAppearance(this, buttonStyle)
    }
    text = component.text
}
