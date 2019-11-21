package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.ScrollView
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.recyclerview.widget.RecyclerView
import br.com.zup.beagleui.framework.widget.core.Flex

internal class ViewFactory {

    fun makeView(context: Context) = View(context)

    fun makeBeagleView(context: Context) =
        BeagleView(context = context)

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

    fun makeAlertDialogBuilder(context: Context) = AlertDialog.Builder(context)
}
