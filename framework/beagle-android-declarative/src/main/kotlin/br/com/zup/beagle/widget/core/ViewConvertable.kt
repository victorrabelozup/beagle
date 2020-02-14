package br.com.zup.beagle.widget.core

import android.content.Context
import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent

interface ViewConvertable : ServerDrivenComponent {
    fun toView(context: Context): View
}