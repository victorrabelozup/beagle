package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.Widget
import br.com.zup.beagleui.framework.layout.Vertical
import br.com.zup.beagleui.framework.util.RowBuilder
import br.com.zup.beagleui.framework.util.generateRows

data class SelectView(
    val remoteDataSource: String? = null,
    val loadingState: Widget? = null,
    @Transient val size: Int,
    @Transient val rowBuilder: RowBuilder
) : Widget {
    override fun buildResultName(): String = "rows"

    override fun build(): Widget {
        return Vertical(children = generateRows(size, rowBuilder))
    }
}