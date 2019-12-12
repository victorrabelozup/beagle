package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.Widget

enum class ListDirection {
    VERTICAL,
    HORIZONTAL
}

typealias RowBuilder = (index: Int) -> Widget

data class ListView(
    val rows: List<Widget>,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null,
    val direction: ListDirection = ListDirection.VERTICAL
) : Widget {

    companion object {
        @JvmStatic
        fun dynamic(
            size: Int,
            direction: ListDirection = ListDirection.VERTICAL,
            rowBuilder: RowBuilder
        ): ListView {
            val rows = generateRows(size, rowBuilder)
            return ListView(rows = rows, direction = direction)
        }

        private fun generateRows(size: Int, rowBuilder: RowBuilder): List<Widget> {
            val children = mutableListOf<Widget>()

            for(i in 0 until size) {
                children.add(rowBuilder(i))
            }

            return children
        }
    }
}