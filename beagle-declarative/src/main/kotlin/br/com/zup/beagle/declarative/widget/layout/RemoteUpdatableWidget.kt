package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Widget

data class RemoteUpdatableWidget(
    val url: String,
    val initialState: Widget
) : Widget
