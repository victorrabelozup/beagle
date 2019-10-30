package br.com.zup.beagleui.framework.engine.renderer.native

import android.content.Context
import android.widget.Button
import android.widget.ImageView
import android.widget.ScrollView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagleui.framework.view.BeagleFlexView
import br.com.zup.beagleui.framework.widget.core.Flex

internal class ViewFactory {

    fun makeBeagleFlexView(context: Context) =
        BeagleFlexView(context = context)

    fun makeBeagleFlexView(context: Context, flex: Flex) =
        BeagleFlexView(context = context, flex = flex)

    fun makeScrollView(context: Context) = ScrollView(context).apply {
        isFillViewport = true
    }

    fun makeButton(context: Context) = Button(context)

    fun makeTextView(context: Context) = TextView(context)

    fun makeImageView(context: Context) = ImageView(context)

    fun makeRecyclerView(context: Context) = RecyclerView(context)
}
