package br.com.zup.beagleui.framework.engine.renderer.native

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.mapper.FlexMapper
import br.com.zup.beagleui.framework.widget.core.Flex
import com.facebook.yoga.YogaNode
import com.facebook.yogalayout.YogaLayout

class YogaFactory(
    private val flexMapper: FlexMapper
) {
    fun makeYogaNode(): YogaNode {
        return YogaNode.create()
    }

    fun makeYogaLayout(context: Context, flex: Flex): YogaLayout {
        return YogaLayout(context, flexMapper.makeYogaNode(flex))
    }

    fun makeYogaLayout(context: Context): YogaLayout {
        return YogaLayout(context)
    }
}
