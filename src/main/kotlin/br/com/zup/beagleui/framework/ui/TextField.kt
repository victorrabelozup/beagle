package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.NativeWidget

data class TextField(
    val hint: String? = null,
    val value: String? = null
) : NativeWidget()