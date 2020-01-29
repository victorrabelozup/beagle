package br.com.zup.beagle.sample.components

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.widget.TextView
import br.com.zup.beagle.sample.widgets.MutableText
import br.com.zup.beagle.view.WidgetViewFactory

class MutableTextView(context: Context) : TextView(context) {

    fun bind(widget: MutableText) {
        val color = Color.parseColor(widget.color)
        text = widget.firstText
        setTextColor(color)
        gravity = Gravity.CENTER
        setOnClickListener {
            this.text = widget.secondText
        }
    }
}

class MutableTextViewFactory : WidgetViewFactory<MutableText> {
    override fun make(context: Context, widget: MutableText): View {
        return MutableTextView(context).apply {
            bind(widget)
        }
    }
}