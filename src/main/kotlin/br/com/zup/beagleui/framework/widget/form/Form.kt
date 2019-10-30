package br.com.zup.beagleui.framework.widget.form

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

enum class FormMethodType {
    GET,
    POST,
    PUT,
    DELETE
}

data class Form (
    val action: String,
    val method: FormMethodType,
    val child: Widget
) : NativeWidget