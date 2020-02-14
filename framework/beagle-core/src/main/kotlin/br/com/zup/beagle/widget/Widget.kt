package br.com.zup.beagle.widget

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.widget.core.Flex

abstract class Widget : FlexComponent, AppearanceComponent {

    private var mFlex: Flex? = null
    private var mAppearance: Appearance? = null

    override val appearance: Appearance?
        get() = mAppearance

    override val flex: Flex?
        get() = mFlex

    open fun applyFlex(flex: Flex): Widget {
        this.mFlex = flex
        return this
    }

    open fun applyAppearance(appearance: Appearance): Widget {
        this.mAppearance = appearance
        return this
    }
}