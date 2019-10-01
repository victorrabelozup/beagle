package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.Horizontal
import br.com.zup.beagleui.framework.widget.layout.Padding
import br.com.zup.beagleui.framework.widget.layout.Spacer
import br.com.zup.beagleui.framework.widget.layout.Stack
import br.com.zup.beagleui.framework.widget.layout.Vertical
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.DropDown
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.widget.ui.ListView
import br.com.zup.beagleui.framework.widget.ui.SelectView
import br.com.zup.beagleui.framework.widget.ui.Text
import br.com.zup.beagleui.framework.widget.ui.TextField
import br.com.zup.beagleui.framework.widget.ui.Toolbar
import com.squareup.moshi.Moshi
import com.squareup.moshi.adapters.PolymorphicJsonAdapterFactory
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

private const val BEAGLE_WIDGET_TYPE = "type"

// Layout
private const val BEAGLE_CONTAINER = "beagle:Container"
private const val BEAGLE_VERTICAL = "beagle:Vertical"
private const val BEAGLE_HORIZONTAL = "beagle:Horizontal"
private const val BEAGLE_STACK = "beagle:Stack"
private const val BEAGLE_SPACER = "beagle:Spacer"
private const val BEAGLE_PADDING = "beagle:Padding"

// UI
private const val BEAGLE_TEXT = "beagle:Text"
private const val BEAGLE_IMAGE = "beagle:Image"
private const val BEAGLE_BUTTON = "beagle:Button"
private const val BEAGLE_DROPDOWN = "beagle:DropDown"
private const val BEAGLE_LIST_VIEW = "beagle:ListView"
private const val BEAGLE_SELECT_VIEW = "beagle:SelectView"
private const val BEAGLE_TEXT_FIELD = "beagle:TextField"
private const val BEAGLE_TOOLBAR = "beagle:Toolbar"

internal class BeagleMoshiFactory {

    fun make(): Moshi {
        val polymorphicJsonAdapterFactory = PolymorphicJsonAdapterFactory.of(Widget::class.java, BEAGLE_WIDGET_TYPE)
            .withSubtype(Container::class.java, BEAGLE_CONTAINER)
            .withSubtype(Vertical::class.java, BEAGLE_VERTICAL)
            .withSubtype(Horizontal::class.java, BEAGLE_HORIZONTAL)
            .withSubtype(Stack::class.java, BEAGLE_STACK)
            .withSubtype(Spacer::class.java, BEAGLE_SPACER)
            .withSubtype(Padding::class.java, BEAGLE_PADDING)
            .withSubtype(Text::class.java, BEAGLE_TEXT)
            .withSubtype(Image::class.java, BEAGLE_IMAGE)
            .withSubtype(Button::class.java, BEAGLE_BUTTON)
            .withSubtype(DropDown::class.java, BEAGLE_DROPDOWN)
            .withSubtype(ListView::class.java, BEAGLE_LIST_VIEW)
            .withSubtype(SelectView::class.java, BEAGLE_SELECT_VIEW)
            .withSubtype(TextField::class.java, BEAGLE_TEXT_FIELD)
            .withSubtype(Toolbar::class.java, BEAGLE_TOOLBAR)

        return Moshi.Builder()
            .add(polymorphicJsonAdapterFactory)
            .add(KotlinJsonAdapterFactory())
            .build()
    }
}

