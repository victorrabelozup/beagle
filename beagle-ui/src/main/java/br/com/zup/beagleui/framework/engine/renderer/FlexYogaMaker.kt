package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.FlexWrap
import br.com.zup.beagleui.framework.widget.core.ItemDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import com.facebook.yoga.YogaAlign
import com.facebook.yoga.YogaDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaWrap

fun makeYogaWrap(flexWrap: FlexWrap): YogaWrap {
    return when (flexWrap) {
        FlexWrap.NO_WRAP -> YogaWrap.NO_WRAP
        FlexWrap.WRAP -> YogaWrap.WRAP
        FlexWrap.WRAP_REVERSE -> YogaWrap.WRAP_REVERSE
    }
}

fun makeYogaAlign(alignment: Alignment): YogaAlign {
    return when (alignment) {
        Alignment.CENTER -> YogaAlign.CENTER
        Alignment.FLEX_START -> YogaAlign.FLEX_START
        Alignment.FLEX_END -> YogaAlign.FLEX_END
        Alignment.SPACE_BETWEEN -> YogaAlign.SPACE_BETWEEN
        Alignment.SPACE_AROUND -> YogaAlign.SPACE_AROUND
        Alignment.BASELINE -> YogaAlign.BASELINE
        Alignment.AUTO -> YogaAlign.AUTO
        Alignment.STRETCH -> YogaAlign.STRETCH
    }
}

fun makeYogaJustify(justifyContent: JustifyContent): YogaJustify {
    return when (justifyContent) {
        JustifyContent.FLEX_START -> YogaJustify.FLEX_START
        JustifyContent.CENTER -> YogaJustify.CENTER
        JustifyContent.FLEX_END -> YogaJustify.FLEX_END
        JustifyContent.SPACE_BETWEEN -> YogaJustify.SPACE_BETWEEN
        JustifyContent.SPACE_AROUND -> YogaJustify.SPACE_AROUND
        JustifyContent.SPACE_EVENLY -> YogaJustify.SPACE_EVENLY
    }
}

fun makeYogaDirection(itemDirection: ItemDirection): YogaDirection {
    return when (itemDirection) {
        ItemDirection.INHERIT -> YogaDirection.INHERIT
        ItemDirection.LTR -> YogaDirection.LTR
        ItemDirection.RTL -> YogaDirection.RTL
    }
}
