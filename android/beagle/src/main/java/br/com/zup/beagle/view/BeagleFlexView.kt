package br.com.zup.beagle.view

import android.annotation.SuppressLint
import android.content.Context
import android.view.View
import br.com.zup.beagle.core.FlexComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.mapper.FlexMapper
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex

@SuppressLint("ViewConstructor")
internal open class BeagleFlexView(
    context: Context,
    flex: Flex,
    private val flexMapper: FlexMapper = FlexMapper()
) : YogaLayout(context, flexMapper.makeYogaNode(flex)) {

    constructor(
        context: Context,
        flexMapper: FlexMapper = FlexMapper()
    ) : this(context, Flex(), flexMapper)

    override fun addView(child: View) {
        super.addView(child)
    }

    fun addView(child: View, flex: Flex) {
        super.addView(child, flexMapper.makeYogaNode(flex))
    }

    fun addServerDrivenComponent(serverDrivenComponent: ServerDrivenComponent) {
        addView(
            serverDrivenComponent.toView(context),
            (serverDrivenComponent as? FlexComponent)?.flex ?: Flex()
        )
    }
}
