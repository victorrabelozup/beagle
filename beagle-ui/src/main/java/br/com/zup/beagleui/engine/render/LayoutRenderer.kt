package br.com.zup.beagleui.engine.render

import com.facebook.litho.Component
import com.facebook.litho.ComponentContext

interface LayoutRenderer<T> {
    fun build(context: ComponentContext, layout: T): Component
}