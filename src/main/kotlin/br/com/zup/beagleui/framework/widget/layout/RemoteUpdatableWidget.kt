package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Widget

data class RemoteUpdatableWidget(
    val url: String,
    val initialState: Widget
) : Widget
