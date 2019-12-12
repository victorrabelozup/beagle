package br.com.zup.beagle.declarative.widget.lazy

import br.com.zup.beagle.declarative.widget.core.Widget

data class LazyWidget(
    val url: String,
    val initialState: Widget
) : Widget
