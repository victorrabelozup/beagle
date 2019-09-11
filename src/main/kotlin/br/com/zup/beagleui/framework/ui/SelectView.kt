package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.Widget
import br.com.zup.beagleui.framework.layout.Vertical
import br.com.zup.beagleui.framework.util.RowBuilder
import br.com.zup.beagleui.framework.util.generateRows

data class SelectView(
    val size: Int,
    val rowBuilder: RowBuilder,
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null
) : Widget() {
    override fun build(): Widget {
        return Vertical(children = generateRows(size, rowBuilder))
    }
}