package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.WidgetView

abstract class InputWidget : WidgetView() {
    /** @suppress */
    abstract fun getValue(): Any

    /** @suppress */
    abstract fun onErrorMessage(message: String)

    /** @suppress */
    override fun applyAppearance(appearance: Appearance): InputWidget {
        return super.applyAppearance(appearance) as InputWidget
    }

    /** @suppress */
    override fun applyFlex(flex: Flex): InputWidget {
        return super.applyFlex(flex) as InputWidget
    }
}