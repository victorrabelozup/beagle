package br.com.zup.beagle.sample.components

import android.content.Context
import android.graphics.Color
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import androidx.core.content.ContextCompat
import br.com.zup.beagle.utils.dp
import br.com.zup.beagle.sample.R
import kotlinx.android.synthetic.main.custom_page_indicator.view.*

typealias OnIndexChanged = (index: Int) -> Unit

class CustomPageIndicatorView(context: Context) : RelativeLayout(context) {

    private val selectedColor: Int = Color.WHITE
    private val unselectedColor: Int = Color.GRAY
    private var selectedItem = 0
    private var pagesCount = 0
    private val llPageIndicator: LinearLayout
    private var onIndexChanged: OnIndexChanged? = null

    init {
        inflate(context, R.layout.custom_page_indicator, this)
        llPageIndicator = findViewById(R.id.llPageIndicator)
        bind()
    }

    private fun bind() {
        val btBack = findViewById<Button>(R.id.btBack)
        val btContinue = findViewById<Button>(R.id.btContinue)
        var newIndex: Int

        btContinue.setOnClickListener {
            newIndex = selectedItem + 1
            if (newIndex < pagesCount) {
                setCurrentIndex(newIndex)
                onIndexChanged?.invoke(newIndex)
            }
        }

        btBack.setOnClickListener {
            newIndex = selectedItem - 1
            if (newIndex >= 0) {
                setCurrentIndex(newIndex)
                onIndexChanged?.invoke(newIndex)
            }
        }
    }

    fun setCount(pages: Int) {
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

    fun setCurrentIndex(newIndex: Int) {
        (llPageIndicator.getChildAt(selectedItem) as ImageView).setColorFilter(unselectedColor)
        (llPageIndicator.getChildAt(newIndex) as ImageView).setColorFilter(selectedColor)
        selectedItem = newIndex
    }

    fun setIndexChangedListener(onIndexChanged: OnIndexChanged) {
        this.onIndexChanged = onIndexChanged
    }

    fun setContinueButtonVisibility(visibility: Int) {
        btContinue.visibility = visibility
    }

    fun setBackButtonVisibility(visibility: Int) {
        btBack.visibility = visibility
    }
}

