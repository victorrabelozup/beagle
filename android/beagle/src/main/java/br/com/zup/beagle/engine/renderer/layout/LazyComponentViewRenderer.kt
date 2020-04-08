/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import androidx.core.view.get
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.lazy.LazyComponent

internal class LazyComponentViewRenderer(
    override val component: LazyComponent,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<LazyComponent>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeBeagleView(rootView.getContext()).apply {
            addServerDrivenComponent(component.initialState, rootView)
            updateView(rootView, component.path, this[0])
        }
    }
}