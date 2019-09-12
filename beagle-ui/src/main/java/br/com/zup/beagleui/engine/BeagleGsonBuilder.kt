package br.com.zup.beagleui.engine

import br.com.zup.beagleui.engine.framework.core.Widget
import br.com.zup.beagleui.engine.framework.layout.*
import br.com.zup.beagleui.engine.framework.ui.*
import com.google.gson.Gson
import com.google.gson.GsonBuilder

// Layout
private const val BEAGLE_WIDGET_TYPE = "type"
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
private const val BEAGLE_STYLED_WIDGET = "beagle:StyledWidget"

fun makeBeagleGson(): Gson {
    val typeAdapterFactory = RuntimeTypeAdapterFactory
        .of(Widget::class.java, BEAGLE_WIDGET_TYPE)
        .registerSubtype(Container::class.java, BEAGLE_CONTAINER)
        .registerSubtype(Vertical::class.java, BEAGLE_VERTICAL)
        .registerSubtype(Horizontal::class.java, BEAGLE_HORIZONTAL)
        .registerSubtype(Stack::class.java, BEAGLE_STACK)
        .registerSubtype(Spacer::class.java, BEAGLE_SPACER)
        .registerSubtype(Padding::class.java, BEAGLE_PADDING)
        .registerSubtype(Text::class.java, BEAGLE_TEXT)
        .registerSubtype(Image::class.java, BEAGLE_IMAGE)
        .registerSubtype(Button::class.java, BEAGLE_BUTTON)
        .registerSubtype(DropDown::class.java, BEAGLE_DROPDOWN)
        .registerSubtype(ListView::class.java, BEAGLE_LIST_VIEW)
        .registerSubtype(SelectView::class.java, BEAGLE_SELECT_VIEW)
        .registerSubtype(TextField::class.java, BEAGLE_TEXT_FIELD)
        .registerSubtype(Toolbar::class.java, BEAGLE_TOOLBAR)
        .registerSubtype(StyledWidget::class.java, BEAGLE_STYLED_WIDGET)

    return GsonBuilder()
        .registerTypeAdapterFactory(typeAdapterFactory)
        .create()
}