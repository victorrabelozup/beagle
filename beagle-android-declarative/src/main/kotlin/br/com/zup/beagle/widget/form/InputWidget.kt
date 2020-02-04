package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.WidgetView

interface InputWidget : WidgetView {
    fun getValue(): Any
    fun onErrorMessage(message: String)
}