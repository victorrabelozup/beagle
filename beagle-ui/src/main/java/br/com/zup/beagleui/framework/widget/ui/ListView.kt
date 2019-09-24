package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class ListView(
    val rows: Widget? = null,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null
) : Widget
