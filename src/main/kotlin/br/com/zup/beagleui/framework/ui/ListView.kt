package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.Widget
import br.com.zup.beagleui.framework.layout.Horizontal
import br.com.zup.beagleui.framework.layout.Vertical
import br.com.zup.beagleui.framework.util.RowBuilder
import br.com.zup.beagleui.framework.util.generateRows

enum class ListDirection {
    VERTICAL,
    HORIZONTAL
}

data class ListView(
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null,
    @Transient val size: Int,
    @Transient val rowBuilder: RowBuilder,
    @Transient val direction: ListDirection = ListDirection.VERTICAL
) : Widget {
    override fun buildResultName(): String = "rows"

    override fun build(): Widget {
        val children = generateRows(size, rowBuilder)

        return if (direction == ListDirection.VERTICAL) {
            Vertical(children = children)
        } else {
            Horizontal(children = children)
        }
    }
}