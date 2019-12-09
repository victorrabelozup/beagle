package br.com.zup.beagleui.sample.widgets

import br.com.zup.beagleui.framework.widget.layout.PageIndicatorWidget

data class CustomPageIndicator(
    val showContinue: Boolean,
    val showSkip: Boolean
) : PageIndicatorWidget
