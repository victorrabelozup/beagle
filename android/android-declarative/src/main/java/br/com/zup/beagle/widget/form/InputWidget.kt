package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.WidgetView

abstract class InputWidget : WidgetView() {

    abstract fun getValue(): Any

    abstract fun onErrorMessage(message: String)

    override fun setId(id: String): InputWidget {
        return super.setId(id) as InputWidget
    }

    override fun applyAppearance(appearance: Appearance): InputWidget {
        return super.applyAppearance(appearance) as InputWidget
    }

    override fun applyFlex(flex: Flex): InputWidget {
        return super.applyFlex(flex) as InputWidget
    }

    override fun applyAccessibility(accessibility: Accessibility): InputWidget {
        return super.applyAccessibility(accessibility) as InputWidget
    }
}