package br.com.zup.beagleui.framework.mockdata

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.view.WidgetViewFactory

class CustomWidgetFactory : WidgetViewFactory<CustomWidget> {
    override fun make(context: Context, widget: CustomWidget): View = View(context)
}