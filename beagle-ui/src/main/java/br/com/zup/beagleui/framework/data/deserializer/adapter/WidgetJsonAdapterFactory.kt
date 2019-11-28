package br.com.zup.beagleui.framework.data.deserializer.adapter

import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.UndefinedWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.lazy.LazyWidget
import br.com.zup.beagleui.framework.widget.navigation.Navigator
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.NavigationBar
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import br.com.zup.beagleui.framework.widget.ui.Text
import com.squareup.moshi.adapters.PolymorphicJsonAdapterFactory

private const val BEAGLE_WIDGET_TYPE = "_beagleType_"
private const val BEAGLE_NAMESPACE = "beagle"
private const val WIDGET_NAMESPACE = "widget"

class WidgetJsonAdapterFactory {

    fun make(): PolymorphicJsonAdapterFactory<Widget> {
        var factory = PolymorphicJsonAdapterFactory.of(
            Widget::class.java, BEAGLE_WIDGET_TYPE
        )
        factory = registerLayoutClass(factory)
        factory = registerUIClass(factory)
        factory = registerCustomWidget(factory)
        factory = registerUndefinedWidget(factory)

        return factory
    }

    private fun registerLayoutClass(
        factory: PolymorphicJsonAdapterFactory<Widget>
    ): PolymorphicJsonAdapterFactory<Widget> {
        return factory.withSubtype(Container::class.java, createNamespaceFor<Container>())
            .withSubtype(FlexWidget::class.java, createNamespaceFor<FlexWidget>())
            .withSubtype(FlexSingleWidget::class.java, createNamespaceFor<FlexSingleWidget>())
            .withSubtype(Vertical::class.java, createNamespaceFor<Vertical>())
            .withSubtype(Horizontal::class.java, createNamespaceFor<Horizontal>())
            .withSubtype(Stack::class.java, createNamespaceFor<Stack>())
            .withSubtype(Spacer::class.java, createNamespaceFor<Spacer>())
            .withSubtype(StatefulWidget::class.java, createNamespaceFor<StatefulWidget>())
            .withSubtype(UpdatableWidget::class.java, createNamespaceFor<UpdatableWidget>())
            .withSubtype(LazyWidget::class.java, createNamespaceFor<LazyWidget>())
    }

    private fun registerUIClass(
        factory: PolymorphicJsonAdapterFactory<Widget>
    ): PolymorphicJsonAdapterFactory<Widget> {
        return factory.withSubtype(Text::class.java, createNamespaceFor<Text>())
            .withSubtype(Image::class.java, createNamespaceFor<Image>())
            .withSubtype(NetworkImage::class.java, createNamespaceFor<NetworkImage>())
            .withSubtype(Button::class.java, createNamespaceFor<Button>())
            .withSubtype(ListView::class.java, createNamespaceFor<ListView>())
            .withSubtype(Navigator::class.java, createNamespaceFor<Navigator>())
            .withSubtype(NavigationBar::class.java, createNamespaceFor<NavigationBar>())
    }

    private fun registerCustomWidget(
        factory: PolymorphicJsonAdapterFactory<Widget>
    ): PolymorphicJsonAdapterFactory<Widget> {
        val appName = BeagleEnvironment.appName
        val widgets = BeagleEnvironment.widgets

        var newFactory = factory

        widgets.forEach {
            newFactory = newFactory.withSubtype(
                it.key, createNamespace(appName, it.key)
            )
        }

        return newFactory
    }

    private fun registerUndefinedWidget(
        factory: PolymorphicJsonAdapterFactory<Widget>
    ): PolymorphicJsonAdapterFactory<Widget> {
        return factory.withDefaultValue(UndefinedWidget())
    }

    private inline fun <reified T : Widget> createNamespaceFor(): String {
        return createNamespace(BEAGLE_NAMESPACE, T::class.java)
    }

    private fun createNamespace(appNamespace: String, clazz: Class<*>): String {
        return "$appNamespace:$WIDGET_NAMESPACE:${clazz.simpleName.toLowerCase()}"
    }
}