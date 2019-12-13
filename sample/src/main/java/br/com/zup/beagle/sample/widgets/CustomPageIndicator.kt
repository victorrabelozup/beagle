package br.com.zup.beagle.sample.widgets

import br.com.zup.beagle.widget.layout.PageIndicatorWidget

data class CustomPageIndicator(
    val showContinue: Boolean,
    val showSkip: Boolean
) : PageIndicatorWidget
