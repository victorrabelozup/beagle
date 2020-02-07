package br.com.zup.beagle.sample.widgets

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.widget.TextView
import br.com.zup.beagle.widget.core.WidgetView

data class MutableText(
    val firstText: String = "",
    val secondText: String = "",
    val color: String = "#000000"
) : WidgetView {
    override fun toView(context: Context) = TextView(context).apply {
        val color = Color.parseColor(color)
        text = firstText
        setTextColor(color)
        gravity = Gravity.CENTER
        setOnClickListener {
            text = if (text == firstText)
                secondText
            else
                firstText
        }
    }
}