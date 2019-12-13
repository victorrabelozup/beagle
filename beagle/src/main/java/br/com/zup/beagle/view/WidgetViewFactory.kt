package br.com.zup.beagle.view

import android.content.Context
import android.view.View
import br.com.zup.beagle.widget.core.Widget

interface WidgetViewFactory<T : Widget> {
    fun make(context: Context, widget: T): View
}
