package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.Widget

data class FormSubmit(
    val child: Widget,
    val enabled: Boolean = true
) : Widget