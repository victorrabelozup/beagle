package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import com.facebook.yoga.YogaPositionType

internal class StackViewRenderer(
    private val viewRendererFactory: ViewRendererFactory,
    private val stack: Stack
) : ViewRenderer {
    override fun build(context: Context): View {
        /*val lithoStack = Column.create(context)
            .positionType(YogaPositionType.ABSOLUTE)

        addFlexToColumn(stack.flex, lithoStack)

        stack.children.forEach { widget ->
            lithoStack.child(make(widget).build(context))
        }

        return lithoStack.build()*/
        return View(context)
    }
}
