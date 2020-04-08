/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexPositionType
import br.com.zup.beagle.widget.layout.Stack

internal class StackViewRenderer(
    override val component: Stack,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Stack>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeBeagleFlexView(rootView.getContext()).apply {
            clipChildren = false
            addChildrenViews(component.children, this, rootView)
        }
    }

    private fun addChildrenViews(
        children: List<ServerDrivenComponent>,
        beagleFlexView: BeagleFlexView,
        rootView: RootView
    ) {
        children.forEach { component ->
            val absoluteFlex =
                (component as? FlexComponent)?.flex?.copy(positionType = FlexPositionType.ABSOLUTE)

            beagleFlexView.addView(
                viewRendererFactory.make(component).build(rootView),
                absoluteFlex ?: Flex(positionType = FlexPositionType.ABSOLUTE)
            )
        }
    }
}
