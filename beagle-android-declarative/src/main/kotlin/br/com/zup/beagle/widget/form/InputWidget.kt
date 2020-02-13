package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.WidgetView

abstract class InputWidget : WidgetView() {
    abstract fun getValue(): Any
    abstract fun onErrorMessage(message: String)
}