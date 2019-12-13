package br.com.zup.beagle.data.deserializer.adapter

import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.UndefinedWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Expanded
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.Horizontal
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.layout.Spacer
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.layout.StatefulWidget
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.layout.Vertical
import br.com.zup.beagle.widget.lazy.LazyWidget
import br.com.zup.beagle.widget.navigation.Navigator
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.NavigationBar
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.Text
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
            .withSubtype(ScrollView::class.java, createNamespaceFor<ScrollView>())
            .withSubtype(Expanded::class.java, createNamespaceFor<Expanded>())
            .withSubtype(LazyWidget::class.java, createNamespaceFor<LazyWidget>())
//            .withSubtype(PageView::class.java, createNamespaceFor<PageView>())
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
//            .withSubtype(PageIndicator::class.java, createNamespaceFor<PageIndicator>())
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