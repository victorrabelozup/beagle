package br.com.zup.beagleui.framework.engine.renderer.native

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.makeYogaAlign
import br.com.zup.beagleui.framework.engine.renderer.makeYogaDirection
import br.com.zup.beagleui.framework.engine.renderer.makeYogaJustify
import br.com.zup.beagleui.framework.engine.renderer.makeYogaWrap
import br.com.zup.beagleui.framework.widget.core.Flex
import com.facebook.yoga.YogaNode
import com.facebook.yogalayout.YogaLayout

class YogaFactory {

    fun makeYogaNode(flex: Flex): YogaNode = YogaNode.create().apply {
        wrap = makeYogaWrap(flex.flexWrap)
        alignContent = makeYogaAlign(flex.alignContent)
        alignItems = makeYogaAlign(flex.alignItems)
        alignSelf = makeYogaAlign(flex.alignSelf)
        justifyContent = makeYogaJustify(flex.justifyContent)
        setDirection(makeYogaDirection(flex.itemDirection))
    }

    fun makeYogaNode(): YogaNode {
        return YogaNode.create()
    }

    fun makeYogaLayout(context: Context, flex: Flex): YogaLayout {
        return YogaLayout(context, makeYogaNode(flex))
    }

    fun makeYogaLayout(context: Context): YogaLayout {
        return YogaLayout(context)
    }
}
