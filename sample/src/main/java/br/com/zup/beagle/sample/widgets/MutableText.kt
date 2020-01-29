package br.com.zup.beagle.sample.widgets

import br.com.zup.beagle.widget.core.Widget

data class MutableText (
    val firstText: String = "",
    val secondText: String = "",
    val color: String = "#000000"
): Widget