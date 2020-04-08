/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.view.setTextWidget
import br.com.zup.beagle.widget.ui.Text

internal class TextViewRenderer(
    override val component: Text,
    private val viewFactory: ViewFactory = ViewFactory()
) : UIViewRenderer<Text>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeTextView(rootView.getContext()).apply {
            setTextWidget(component)
        }
    }
}
