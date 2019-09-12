package br.com.zup.beagleui.engine.framework.ui

import br.com.zup.beagleui.engine.framework.core.Widget

data class TextField(
    val hint: String? = null,
    val value: String? = null
) : Widget