package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.Flex

abstract class InputWidget : Widget() {

    override fun applyAppearance(appearance: Appearance): InputWidget {
        return super.applyAppearance(appearance) as InputWidget
    }

    override fun applyFlex(flex: Flex): InputWidget {
        return super.applyFlex(flex) as InputWidget
    }
}