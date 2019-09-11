package br.com.zup.beagleui.framework.util

import br.com.zup.beagleui.framework.core.Widget

typealias RowBuilder = (index: Int) -> Widget

fun generateRows(size: Int, rowBuilder: RowBuilder): List<Widget> {
    val children = mutableListOf<Widget>()

    for(i in 0 until size) {
        children.add(rowBuilder(i))
    }

    return children
}