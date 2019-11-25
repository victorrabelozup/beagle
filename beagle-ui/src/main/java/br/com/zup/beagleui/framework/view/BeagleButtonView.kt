package br.com.zup.beagleui.framework.view

import android.content.Context
import androidx.appcompat.widget.AppCompatButton
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.widget.ui.Button as ButtonWidget

internal class BeagleButtonView(context: Context) : AppCompatButton(context),
    OnStateUpdatable<ButtonWidget> {
    override fun onUpdateState(widget: ButtonWidget) {
        this.setData(widget)
    }
}