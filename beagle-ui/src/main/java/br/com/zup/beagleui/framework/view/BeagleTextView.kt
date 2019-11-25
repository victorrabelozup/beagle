package br.com.zup.beagleui.framework.view

import android.content.Context
import androidx.appcompat.widget.AppCompatTextView
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.widget.ui.Text

internal class BeagleTextView(context: Context) : AppCompatTextView(context), OnStateUpdatable<Text> {
    override fun onUpdateState(widget: Text) {
        this.setData(widget)
    }
}