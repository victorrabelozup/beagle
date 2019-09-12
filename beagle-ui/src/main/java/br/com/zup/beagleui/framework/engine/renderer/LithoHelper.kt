package br.com.zup.beagleui.framework.engine.renderer

import br.com.zup.beagleui.framework.widget.core.Flex
import com.facebook.litho.Column
import com.facebook.litho.Row

fun addFlexToColumn(flex: Flex, columnBuilder: Column.Builder) {
    columnBuilder.justifyContent(makeYogaJustify(flex.justifyContent))
        .alignContent(makeYogaAlign(flex.alignContent))
        .alignItems(makeYogaAlign(flex.alignItems))
        .alignSelf(makeYogaAlign(flex.alignSelf))
        .wrap(makeYogaWrap(flex.flexWrap))
        .layoutDirection(makeYogaDirection(flex.itemDirection))
}

fun addFlexToRow(flex: Flex, rowBuilder: Row.Builder) {
    rowBuilder.justifyContent(makeYogaJustify(flex.justifyContent))
        .alignContent(makeYogaAlign(flex.alignContent))
        .alignItems(makeYogaAlign(flex.alignItems))
        .alignSelf(makeYogaAlign(flex.alignSelf))
        .wrap(makeYogaWrap(flex.flexWrap))
        .layoutDirection(makeYogaDirection(flex.itemDirection))
}