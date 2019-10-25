package br.com.zup.beagleui.framework.utils

import android.content.Context
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.widget.core.Widget

internal var viewRenderer = ViewRendererFactory()

fun Widget.toView(context: Context) = viewRenderer.make(this).build(context)