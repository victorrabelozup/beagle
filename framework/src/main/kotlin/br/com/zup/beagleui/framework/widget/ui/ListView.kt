package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Vertical

enum class ListDirection {
    VERTICAL,
    HORIZONTAL
}

typealias RowBuilder = (index: Int) -> Widget

data class ListView(
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null,
    @Transient val size: Int,
    @Transient val rowBuilder: RowBuilder,
    @Transient val direction: ListDirection = ListDirection.VERTICAL
) : Widget {

    override fun build(): Widget {
        val children = generateRows(size, rowBuilder)

        return if (direction == ListDirection.VERTICAL) {
            Vertical(children = children)
        } else {
            Horizontal(children = children)
        }
    }

    private fun generateRows(size: Int, rowBuilder: RowBuilder): List<Widget> {
        val children = mutableListOf<Widget>()

        for(i in 0 until size) {
            children.add(rowBuilder(i))
        }

        return children
    }
}