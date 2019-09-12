package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.Widget

data class TextField(
    val hint: String? = null,
    val value: String? = null
) : Widget