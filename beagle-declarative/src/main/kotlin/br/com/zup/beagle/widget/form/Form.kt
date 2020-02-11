package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.Widget

enum class FormMethodType {
    GET,
    POST,
    PUT,
    DELETE
}

data class Form (
    val path: String,
    val method: FormMethodType,
    val child: Widget
) : Widget