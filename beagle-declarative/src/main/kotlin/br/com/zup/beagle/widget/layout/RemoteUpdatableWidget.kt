package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class RemoteUpdatableWidget(
    val url: String,
    val initialState: Widget
) : Widget
