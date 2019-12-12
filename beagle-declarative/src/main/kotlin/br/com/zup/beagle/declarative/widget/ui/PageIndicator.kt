package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.layout.PageIndicatorWidget

data class PageIndicator(
    val selectedColor: String,
    val unselectedColor: String
) : PageIndicatorWidget
