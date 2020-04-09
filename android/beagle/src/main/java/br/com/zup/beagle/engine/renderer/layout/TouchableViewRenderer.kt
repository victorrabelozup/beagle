/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.data.PreFetchHelper
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.navigation.Touchable

internal class TouchableViewRenderer(
    override val component: Touchable,
    private val actionExecutor: ActionExecutor = ActionExecutor(),
    private val preFetchHelper: PreFetchHelper = PreFetchHelper(),
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Touchable>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        preFetchHelper.handlePreFetch(rootView, component.action)
        return viewRendererFactory.make(component.child).build(rootView).apply {
            setOnClickListener {
                actionExecutor.doAction(context, component.action)
                component.clickAnalyticsEvent?.let {
                    BeagleEnvironment.beagleSdk.analytics?.
                    sendClickEvent(it)
                }
            }
        }
    }
}
