package br.com.zup.beagleui.framework.engine.renderer.native

import android.content.Context
import android.widget.ScrollView

class ViewFactory {

    fun makeScrollView(context: Context): ScrollView {
        return ScrollView(context).apply {
            isFillViewport = true
        }
    }
}
