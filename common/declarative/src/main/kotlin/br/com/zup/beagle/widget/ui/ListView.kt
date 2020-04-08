/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget

enum class ListDirection {
    VERTICAL,
    HORIZONTAL
}

typealias RowBuilder = (index: Int) -> Widget

data class ListView(
    val rows: List<ServerDrivenComponent>,
    val direction: ListDirection = ListDirection.VERTICAL
) : ServerDrivenComponent, LayoutComponent {

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

            for (i in 0 until size) {
                children.add(rowBuilder(i))
            }

            return children
        }
    }
}
