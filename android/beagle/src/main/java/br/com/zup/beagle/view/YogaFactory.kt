package br.com.zup.beagle.view

import android.content.Context
import br.com.zup.beagle.engine.mapper.FlexMapper
import br.com.zup.beagle.widget.core.Flex
import com.facebook.yoga.YogaNode
import com.facebook.yoga.YogaNodeFactory

class YogaFactory(
    private val flexMapper: FlexMapper
) {
    fun makeYogaNode(): YogaNode {
        return YogaNodeFactory.create()
    }

    fun makeYogaLayout(context: Context, flex: Flex): YogaLayout {
        return YogaLayout(context, flexMapper.makeYogaNode(flex))
    }

    fun makeYogaLayout(context: Context): YogaLayout {
        return YogaLayout(context)
    }
}
