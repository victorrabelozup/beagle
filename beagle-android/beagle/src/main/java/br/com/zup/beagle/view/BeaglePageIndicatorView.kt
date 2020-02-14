package br.com.zup.beagle.view

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.view.View
import br.com.zup.beagle.utils.dp

class BeaglePageIndicatorView(context: Context) : View(context) {

    private var selectedItem = 0
    private var pagesCount = 0
    private var selectedColor: Int = Color.WHITE
    private var unselectedColor: Int = Color.GRAY
    private val paint = Paint(Paint.ANTI_ALIAS_FLAG)

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

    fun setSelectedColor(color: Int) {
        selectedColor = color
        invalidate()
    }

    fun setUnselectedColor(color: Int) {
        unselectedColor = color
        invalidate()
    }

    fun setCount(pages: Int) {
        pagesCount = pages
        invalidate()
    }

    fun setCurrentIndex(newIndex: Int) {
        selectedItem = newIndex
        invalidate()
    }
}
