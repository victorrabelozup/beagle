package br.com.zup.beagleui.framework.view

import android.annotation.SuppressLint
import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.mapper.FlexMapper
import br.com.zup.beagleui.framework.widget.core.Flex
import com.facebook.yogalayout.YogaLayout

@SuppressLint("ViewConstructor")
internal open class BeagleFlexView(
    context: Context,
    flex: Flex,
    private val flexMapper: FlexMapper = FlexMapper()
) : YogaLayout(context, flexMapper.makeYogaNode(flex)) {

    constructor(
        context: Context,
        flexMapper: FlexMapper = FlexMapper()
    ) : this(context, Flex(), flexMapper)

    override fun addView(child: View) {
        super.addView(child)
    }

    fun addView(child: View, flex: Flex) {
        super.addView(child, flexMapper.makeYogaNode(flex))
    }
}
