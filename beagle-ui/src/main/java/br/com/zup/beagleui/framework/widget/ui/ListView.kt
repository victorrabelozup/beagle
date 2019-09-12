package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

enum class ListDirection {
    VERTICAL,
    HORIZONTAL
}

data class ListView(
    val rows: List<Widget>? = null,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null,
    val direction: ListDirection = ListDirection.VERTICAL
) : Widget