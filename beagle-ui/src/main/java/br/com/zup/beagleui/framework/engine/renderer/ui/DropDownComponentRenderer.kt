package br.com.zup.beagleui.framework.engine.renderer.ui

import br.com.zup.beagleui.framework.widget.ui.DropDown
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.Row

class DropDownComponentRenderer(
    private val dropDown: DropDown
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        return Row.create(context).build()
    }
}
