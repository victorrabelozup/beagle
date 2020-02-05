package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

internal data class ScreenWidget(
    val navigationBar: NavigationBar? = null,
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : Widget