package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.FlexWrap
import br.com.zup.beagleui.framework.widget.core.Direction
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.FlexDisplay
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import com.facebook.yoga.YogaAlign
import com.facebook.yoga.YogaDirection
import com.facebook.yoga.YogaDisplay
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaJustify
import com.facebook.yoga.YogaWrap

internal fun makeYogaWrap(flexWrap: FlexWrap): YogaWrap = when (flexWrap) {
    FlexWrap.NO_WRAP -> YogaWrap.NO_WRAP
    FlexWrap.WRAP -> YogaWrap.WRAP
    FlexWrap.WRAP_REVERSE -> YogaWrap.WRAP_REVERSE
}

internal fun makeYogaAlign(alignment: Alignment): YogaAlign = when (alignment) {
    Alignment.CENTER -> YogaAlign.CENTER
    Alignment.FLEX_START -> YogaAlign.FLEX_START
    Alignment.FLEX_END -> YogaAlign.FLEX_END
    Alignment.SPACE_BETWEEN -> YogaAlign.SPACE_BETWEEN
    Alignment.SPACE_AROUND -> YogaAlign.SPACE_AROUND
    Alignment.BASELINE -> YogaAlign.BASELINE
    Alignment.AUTO -> YogaAlign.AUTO
    Alignment.STRETCH -> YogaAlign.STRETCH
}

internal fun makeYogaJustify(justifyContent: JustifyContent): YogaJustify = when (justifyContent) {
    JustifyContent.FLEX_START -> YogaJustify.FLEX_START
    JustifyContent.CENTER -> YogaJustify.CENTER
    JustifyContent.FLEX_END -> YogaJustify.FLEX_END
    JustifyContent.SPACE_BETWEEN -> YogaJustify.SPACE_BETWEEN
    JustifyContent.SPACE_AROUND -> YogaJustify.SPACE_AROUND
    JustifyContent.SPACE_EVENLY -> YogaJustify.SPACE_EVENLY
}

internal fun makeYogaDirection(direction: Direction): YogaDirection = when (direction) {
    Direction.INHERIT -> YogaDirection.INHERIT
    Direction.LTR -> YogaDirection.LTR
    Direction.RTL -> YogaDirection.RTL
}

internal fun makeYogaFlexDirection(flexDirection: FlexDirection): YogaFlexDirection = when (flexDirection) {
    FlexDirection.COLUMN -> YogaFlexDirection.COLUMN
    FlexDirection.ROW -> YogaFlexDirection.ROW
    FlexDirection.COLUMN_REVERSE -> YogaFlexDirection.COLUMN_REVERSE
    FlexDirection.ROW_REVERSE -> YogaFlexDirection.ROW_REVERSE
}

internal fun makeYogaDisplay(display: FlexDisplay): YogaDisplay = when (display) {
    FlexDisplay.FLEX -> YogaDisplay.FLEX
    FlexDisplay.NONE -> YogaDisplay.NONE
}
