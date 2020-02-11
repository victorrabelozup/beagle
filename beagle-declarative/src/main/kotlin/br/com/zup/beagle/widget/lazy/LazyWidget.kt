package br.com.zup.beagle.widget.lazy

import br.com.zup.beagle.widget.core.Widget

data class LazyWidget(
    val path: String,
    val initialState: Widget
) : Widget