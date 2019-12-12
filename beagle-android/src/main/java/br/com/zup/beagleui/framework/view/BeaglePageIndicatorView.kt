package br.com.zup.beagleui.framework.view

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.view.View
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.widget.ui.PageIndicator

interface PageIndicatorInput {

    fun setCount(pages: Int)
    fun onItemUpdated(newIndex: Int)
    fun initPageView(pageIndicatorOutput: PageIndicatorOutput)
}

class BeaglePageIndicatorView(context: Context) : View(context), PageIndicatorInput {

    private var selectedItem = 0
    private var pagesCount = 0
    private var selectedColor: Int = Color.WHITE
    private var unselectedColor: Int = Color.GRAY
    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)

    fun setWidget(widget: PageIndicator) {
        selectedColor = Color.parseColor(widget.selectedColor)
        unselectedColor = Color.parseColor(widget.unselectedColor)
        invalidate()
    }

    override fun setCount(pages: Int) {
        pagesCount = pages
        invalidate()
    }

    override fun onDraw(canvas: Canvas?) {
        for (i in 0 until pagesCount) {
            if (i == selectedItem) {
                paint.color = selectedColor
            } else {
                paint.color = unselectedColor
            }
            canvas?.drawCircle(
                (width - (2 * pagesCount * 6f.dp() + 6f.dp() * (pagesCount - 1))) / 2 +
                        2 * i * 6f.dp() + 6f.dp() + i * 6f.dp(),
                height / 2f,
                6f.dp(),
                paint
            )
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        setMeasuredDimension(MeasureSpec.getSize(widthMeasureSpec), 25.dp())
    }

    override fun onItemUpdated(newIndex: Int) {
        selectedItem = newIndex
        invalidate()
    }

    override fun initPageView(pageIndicatorOutput: PageIndicatorOutput) {}
}
