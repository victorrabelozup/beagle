package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.DumbWidget

data class TextField(
    val hint: String? = null,
    val value: String? = null
) : DumbWidget()