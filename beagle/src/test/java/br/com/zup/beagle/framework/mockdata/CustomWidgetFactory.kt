package br.com.zup.beagle.mockdata

import android.content.Context
import android.view.View
import br.com.zup.beagle.view.WidgetViewFactory

class CustomWidgetFactory : WidgetViewFactory<CustomWidget> {
    override fun make(context: Context, widget: CustomWidget): View = View(context)
}