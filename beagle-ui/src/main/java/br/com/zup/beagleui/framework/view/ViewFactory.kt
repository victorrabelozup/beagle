package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import android.widget.HorizontalScrollView
import android.widget.ImageView
import android.widget.ScrollView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.Toolbar
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

    fun makeScrollView(context: Context) =
        ScrollView(context).apply {
            isFillViewport = true
        }

    fun makeHorizontalScrollView(context: Context) =
        HorizontalScrollView(context).apply {
            isFillViewport = true
        }

    fun makeButton(context: Context) = BeagleButtonView(context)

    fun makeTextView(context: Context) = BeagleTextView(context)

    fun makeImageView(context: Context) = ImageView(context)

    fun makeRecyclerView(context: Context) = RecyclerView(context)

    fun makeAlertDialogBuilder(context: Context) = AlertDialog.Builder(context)

    fun makeNavigationBar(context: Context) = Toolbar(context)

    fun makeFrameLayout(context: Context) = FrameLayout(context)

    fun makeFrameLayoutParams(width: Int, height: Int) = FrameLayout.LayoutParams(width, height)
}
