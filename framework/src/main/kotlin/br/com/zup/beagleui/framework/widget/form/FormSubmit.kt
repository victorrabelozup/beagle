package br.com.zup.beagleui.framework.widget.form

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class FormSubmit(
    val url: String,
    val child: Widget
) : NativeWidget()