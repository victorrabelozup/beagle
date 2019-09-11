package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.Widget

data class Container(
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : Widget() {
    override fun build(): Widget {
       val container = mutableListOf<Widget>()

        if (header != null) {
            container.add(header)
        }

        container.add(content)

        if (footer != null) {
            container.add(footer)
        }

        return Vertical(children = container)
    }
}