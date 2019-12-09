package br.com.zup.beagleui.sample.components

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import androidx.core.content.ContextCompat
import br.com.zup.beagleui.framework.view.PageIndicatorInput
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.view.PageIndicatorOutput
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.sample.R
import br.com.zup.beagleui.sample.widgets.CustomPageIndicator

class CustomPageIndicatorView(context: Context) : RelativeLayout(context), PageIndicatorInput {

    private val selectedColor: Int = Color.WHITE
    private val unselectedColor: Int = Color.GRAY
    private var selectedItem = 0
    private var pagesCount = 0
    private val llPageIndicator: LinearLayout
    lateinit var output: PageIndicatorOutput

    init {
        inflate(context, R.layout.custom_page_indicator, this)
        llPageIndicator = findViewById(R.id.llPageIndicator)
    }

    fun bind(widget: CustomPageIndicator) {
        val btBack = findViewById<Button>(R.id.btBack)
        val btContinue = findViewById<Button>(R.id.btContinue)
        var newIndex: Int
        if (!widget.showContinue) {
            btContinue.visibility = INVISIBLE
        } else {
            btContinue.setOnClickListener {
                newIndex = selectedItem + 1
                if (newIndex < pagesCount) {
                    onItemUpdated(newIndex)
                    output.swapToPage(newIndex)
                }
            }
        }
        if (!widget.showSkip) {
            btBack.visibility = INVISIBLE
        } else {
            btBack.setOnClickListener {
                newIndex = selectedItem - 1
                if (newIndex >= 0) {
                    onItemUpdated(newIndex)
                    output.swapToPage(newIndex)
                }
            }
        }
    }

    override fun setCount(pages: Int) {
        for (i in 0 until pages) {
            val dot = ImageView(context)
            dot.id = i
            dot.setImageDrawable(ContextCompat.getDrawable(context, R.drawable.indicator_default))
            if (i == 0) {
                dot.setColorFilter(selectedColor)
            } else {
                dot.setColorFilter(unselectedColor)
            }

            llPageIndicator.addView(dot)

            val dotParams = dot.layoutParams as LinearLayout.LayoutParams
            val defaultSize = 10.dp()
            val horizontalMargin = 6.dp()
            val verticalMargin = 6.dp()
            dotParams.height = defaultSize
            dotParams.width = defaultSize
            dotParams.setMargins(
                horizontalMargin,
                verticalMargin,
                horizontalMargin,
                verticalMargin
            )
            dot.layoutParams = dotParams
        }
        pagesCount = pages
    }

    override fun onItemUpdated(newIndex: Int) {
        (llPageIndicator.getChildAt(selectedItem) as ImageView).setColorFilter(unselectedColor)
        (llPageIndicator.getChildAt(newIndex) as ImageView).setColorFilter(selectedColor)
        selectedItem = newIndex
    }

    override fun initPageView(pageIndicatorOutput: PageIndicatorOutput) {
        output = pageIndicatorOutput
    }
}

class CustomPageIndicatorFactory : WidgetViewFactory<CustomPageIndicator> {
    override fun make(context: Context, widget: CustomPageIndicator): View {
        return CustomPageIndicatorView(context).apply {
            bind(widget)
        }
    }
}
