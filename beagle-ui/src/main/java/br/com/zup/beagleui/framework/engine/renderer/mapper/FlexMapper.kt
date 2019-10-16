package br.com.zup.beagleui.framework.engine.renderer.mapper

import br.com.zup.beagleui.framework.engine.renderer.makeYogaAlign
import br.com.zup.beagleui.framework.engine.renderer.makeYogaDirection
import br.com.zup.beagleui.framework.engine.renderer.makeYogaDisplay
import br.com.zup.beagleui.framework.engine.renderer.makeYogaFlexDirection
import br.com.zup.beagleui.framework.engine.renderer.makeYogaJustify
import br.com.zup.beagleui.framework.engine.renderer.makeYogaWrap
import br.com.zup.beagleui.framework.utils.px
import br.com.zup.beagleui.framework.widget.core.EdgeValue
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Size
import br.com.zup.beagleui.framework.widget.core.UnitType
import br.com.zup.beagleui.framework.widget.core.UnitValue
import com.facebook.yoga.YogaEdge
import com.facebook.yoga.YogaNode

class FlexMapper {

    fun makeYogaNode(flex: Flex): YogaNode = YogaNode.create().apply {
        flexDirection = makeYogaFlexDirection(flex.flexDirection)
        setDirection(makeYogaDirection(flex.direction))
        wrap = makeYogaWrap(flex.flexWrap)
        justifyContent = makeYogaJustify(flex.justifyContent)
        alignItems = makeYogaAlign(flex.alignItems)
        alignSelf = makeYogaAlign(flex.alignSelf)
        alignContent = makeYogaAlign(flex.alignContent)
        flexGrow = flex.grow.toFloat()
        flexShrink = flex.shrink.toFloat()
        display = makeYogaDisplay(flex.display)
        applyAttributes(flex, this)
    }

    private fun applyAttributes(flex: Flex, yogaNode: YogaNode) {
        setWidth(flex.size, yogaNode)
        setHeight(flex.size, yogaNode)
        setMaxWidth(flex.size, yogaNode)
        setMaxHeight(flex.size, yogaNode)
        setMinWidth(flex.size, yogaNode)
        setMinHeight(flex.size, yogaNode)
        setBasis(flex.basis, yogaNode)
        setAspectRatio(flex.size.aspectRatio, yogaNode)
        setMargin(flex.margin, yogaNode)
        setPadding(flex.padding, yogaNode)
        setPosition(flex.position, yogaNode)
    }

    private fun setWidth(size: Size, yogaNode: YogaNode) {
        size.width?.let { width ->
            if (width.type == UnitType.REAL) {
                yogaNode.setWidth(width.value.px().toFloat())
            } else if (width.type == UnitType.PERCENT) {
                yogaNode.setWidthPercent(width.value.toFloat())
            }
        }
    }

    private fun setHeight(size: Size, yogaNode: YogaNode) {
        size.height?.let { height ->
            if (height.type == UnitType.REAL) {
                yogaNode.setHeight(height.value.px().toFloat())
            } else if (height.type == UnitType.PERCENT) {
                yogaNode.setHeightPercent(height.value.toFloat())
            }
        }
    }

    private fun setMaxWidth(size: Size, yogaNode: YogaNode) {
        size.maxWidth?.let { maxWidth ->
            if (maxWidth.type == UnitType.REAL) {
                yogaNode.setMaxWidth(maxWidth.value.px().toFloat())
            } else if (maxWidth.type == UnitType.PERCENT) {
                yogaNode.setMaxWidthPercent(maxWidth.value.toFloat())
            }
        }
    }

    private fun setMaxHeight(size: Size, yogaNode: YogaNode) {
        size.maxHeight?.let { maxHeight ->
            if (maxHeight.type == UnitType.REAL) {
                yogaNode.setMaxHeight(maxHeight.value.px().toFloat())
            } else if (maxHeight.type == UnitType.PERCENT) {
                yogaNode.setMaxHeightPercent(maxHeight.value.toFloat())
            }
        }
    }

    private fun setMinWidth(size: Size, yogaNode: YogaNode) {
        size.minWidth?.let { minWidth ->
            if (minWidth.type == UnitType.REAL) {
                yogaNode.setMinWidth(minWidth.value.px().toFloat())
            } else if (minWidth.type == UnitType.PERCENT) {
                yogaNode.setMinWidthPercent(minWidth.value.toFloat())
            }
        }
    }

    private fun setMinHeight(size: Size, yogaNode: YogaNode) {
        size.minHeight?.let { minHeight ->
            if (minHeight.type == UnitType.REAL) {
                yogaNode.setMinHeight(minHeight.value.px().toFloat())
            } else if (minHeight.type == UnitType.PERCENT) {
                yogaNode.setMinHeightPercent(minHeight.value.toFloat())
            }
        }
    }

    private fun setAspectRatio(aspectRatio: Double?, yogaNode: YogaNode) {
        aspectRatio?.let {
            yogaNode.aspectRatio = aspectRatio.toFloat()
        }
    }

    private fun setBasis(basis: UnitValue, yogaNode: YogaNode) {
        when {
            basis.type == UnitType.REAL -> yogaNode.setFlexBasis(basis.value.toFloat())
            basis.type == UnitType.PERCENT -> yogaNode.setFlexBasisPercent(basis.value.toFloat())
            else -> yogaNode.setFlexBasisAuto()
        }
    }

    private fun setMargin(margin: EdgeValue, yogaNode: YogaNode) {
        applyEdgeValue(margin) { yogaEdge, unitValue ->
            if (unitValue.type == UnitType.REAL) {
                yogaNode.setMargin(yogaEdge, unitValue.value.px().toFloat())
            } else if (unitValue.type == UnitType.PERCENT) {
                yogaNode.setMarginPercent(yogaEdge, unitValue.value.toFloat())
            }
        }
    }

    private fun setPadding(margin: EdgeValue, yogaNode: YogaNode) {
        applyEdgeValue(margin) { yogaEdge, unitValue ->
            if (unitValue.type == UnitType.REAL) {
                yogaNode.setPadding(yogaEdge, unitValue.value.px().toFloat())
            } else if (unitValue.type == UnitType.PERCENT) {
                yogaNode.setPaddingPercent(yogaEdge, unitValue.value.toFloat())
            }
        }
    }

    private fun setPosition(position: EdgeValue, yogaNode: YogaNode) {
        applyEdgeValue(position) { yogaEdge, unitValue ->
            if (unitValue.type == UnitType.REAL) {
                yogaNode.setPosition(yogaEdge, unitValue.value.px().toFloat())
            } else if (unitValue.type == UnitType.PERCENT) {
                yogaNode.setPositionPercent(yogaEdge, unitValue.value.toFloat())
            }
        }
    }

    private fun applyEdgeValue(edgeValue: EdgeValue, finish: (yogaEdge: YogaEdge, unitValue: UnitValue) -> Unit) {
        edgeValue.top?.let {
            finish(YogaEdge.TOP, it)
        }
        edgeValue.left?.let {
            finish(YogaEdge.LEFT, it)
        }
        edgeValue.right?.let {
            finish(YogaEdge.RIGHT, it)
        }
        edgeValue.bottom?.let {
            finish(YogaEdge.BOTTOM, it)
        }
        edgeValue.start?.let {
            finish(YogaEdge.START, it)
        }
        edgeValue.end?.let {
            finish(YogaEdge.END, it)
        }
        edgeValue.vertical?.let {
            finish(YogaEdge.VERTICAL, it)
        }
        edgeValue.horizontal?.let {
            finish(YogaEdge.HORIZONTAL, it)
        }
        edgeValue.all?.let {
            finish(YogaEdge.ALL, it)
        }
    }
}
