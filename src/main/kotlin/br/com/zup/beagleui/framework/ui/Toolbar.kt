package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.NativeWidget

data class Toolbar(
    val title: String,
    val showBackButton: Boolean = true
) : NativeWidget()