package br.com.zup.beagleui.engine.framework.ui

import br.com.zup.beagleui.engine.framework.core.Widget

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