package br.com.zup.beagle.widget

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.AccessibilityComponent
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.widget.core.Flex

abstract class Widget : FlexComponent, AppearanceComponent, AccessibilityComponent {

    final override var flex: Flex? = null
        private set
    final override var appearance: Appearance? = null
        private set
    final override var accessibility: Accessibility? = null
        private set

    open fun applyFlex(flex: Flex): Widget {
        this.flex = flex
        return this
    }

    open fun applyAppearance(appearance: Appearance): Widget {
        this.appearance = appearance
        return this
    }

    open fun applyAccessibility(accessibility: Accessibility): Widget {
        this.accessibility = accessibility
        return this
    }
}