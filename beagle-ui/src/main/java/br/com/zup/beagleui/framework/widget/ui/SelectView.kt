package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class SelectView (
    val rows: List<Widget>? = null,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null
) : Widget