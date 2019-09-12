package br.com.zup.beagleui.engine.framework.ui

import br.com.zup.beagleui.engine.framework.core.Widget

data class SelectView (
    val rows: List<Widget>? = null,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null
) : Widget