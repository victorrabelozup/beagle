package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.Widget

data class Stack(
    val children: List<Widget>,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget