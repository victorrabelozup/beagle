package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.mapper.FlexMapper
import br.com.zup.beagleui.framework.widget.core.Flex
import com.facebook.yogalayout.YogaLayout

internal class BeagleFlexView(
    private val flexMapper: FlexMapper = FlexMapper(),
    context: Context,
    flex: Flex
) : YogaLayout(context, flexMapper.makeYogaNode(flex)) {

    constructor(
        flexMapper: FlexMapper = FlexMapper(),
        context: Context
    ) : this(flexMapper, context, Flex())

    override fun addView(child: View) {
        super.addView(child)
    }

    fun addView(child: View, flex: Flex) {
        super.addView(child, flexMapper.makeYogaNode(flex))
    }
}
