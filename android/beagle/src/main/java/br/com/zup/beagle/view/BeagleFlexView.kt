package br.com.zup.beagle.view

import android.annotation.SuppressLint
import android.content.Context
import android.view.View
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.mapper.FlexMapper
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.widget.core.Flex

@SuppressLint("ViewConstructor")
internal open class BeagleFlexView(
    context: Context,
    flex: Flex,
    private val flexMapper: FlexMapper = FlexMapper(),
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : YogaLayout(context, flexMapper.makeYogaNode(flex)) {

    constructor(
        context: Context,
        flexMapper: FlexMapper = FlexMapper()
    ) : this(context, Flex(), flexMapper)

//    @Deprecated(
//        message = "Use addServerDrivenComponent instead",
//        replaceWith = ReplaceWith("addServerDrivenComponent")
//    )
//    override fun addView(child: View) {
//        throw IllegalStateException("Illegal call to addView, use addServerDrivenComponent instead")
//    }

    fun addView(child: View, flex: Flex) {
        super.addView(child, flexMapper.makeYogaNode(flex))
    }

    fun addServerDrivenComponent(serverDrivenComponent: ServerDrivenComponent, rootView: RootView) {
        val flex = (serverDrivenComponent as? FlexComponent)?.flex ?: Flex()
        super.addView(
            viewRendererFactory.make(serverDrivenComponent).build(rootView),
            flexMapper.makeYogaNode(flex)
        )
    }
}
