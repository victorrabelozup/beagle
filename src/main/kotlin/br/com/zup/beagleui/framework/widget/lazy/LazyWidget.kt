package br.com.zup.beagleui.framework.widget.lazy

import br.com.zup.beagleui.framework.widget.core.Widget

data class LazyWidget(
    val url: String,
    val initialState: Widget
) : Widget
