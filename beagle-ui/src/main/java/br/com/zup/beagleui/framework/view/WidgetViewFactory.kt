package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.widget.core.NativeWidget

interface WidgetViewFactory<T : NativeWidget> {
    fun make(context: Context, widget: T): View
}
