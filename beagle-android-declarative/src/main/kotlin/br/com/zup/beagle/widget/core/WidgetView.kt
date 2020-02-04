package br.com.zup.beagle.widget.core

import android.content.Context
import android.view.View

interface WidgetView : Widget {
    fun toView(context: Context): View
}