package br.com.zup.beagle.widget

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.widget.core.Flex

abstract class Widget : FlexComponent, AppearanceComponent {

    final override var flex: Flex? = null
        private set
    final override var appearance: Appearance? = null
        private set

    open fun applyFlex(flex: Flex): Widget {
        this.flex = flex
        return this
    }

    open fun applyAppearance(appearance: Appearance): Widget {
        this.appearance = appearance
        return this
    }
}