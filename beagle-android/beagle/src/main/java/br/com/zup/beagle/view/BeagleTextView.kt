package br.com.zup.beagle.view

import android.content.Context
import androidx.appcompat.widget.AppCompatTextView
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.widget.ui.Text

internal class BeagleTextView(context: Context) : AppCompatTextView(context), OnStateUpdatable<Text> {
    override fun onUpdateState(widget: Text) {
        this.setData(widget)
    }
}