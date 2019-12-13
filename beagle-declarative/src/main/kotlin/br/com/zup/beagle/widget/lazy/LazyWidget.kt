package br.com.zup.beagle.widget.lazy

import br.com.zup.beagle.widget.core.Widget

data class LazyWidget(
    val url: String,
    val initialState: Widget
) : Widget
