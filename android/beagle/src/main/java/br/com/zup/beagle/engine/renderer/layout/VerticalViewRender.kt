/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.layout

import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Vertical

internal class VerticalViewRender(
    override val component: Vertical,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : DirectionalViewRenderer<Vertical>(
    component.children,
    Flex(),
    viewRendererFactory,
    viewFactory
) {

    override fun getYogaFlexDirection(): FlexDirection {
        return if (component.reversed == true) {
            FlexDirection.COLUMN_REVERSE
        } else {
            FlexDirection.COLUMN
        }
    }
}
