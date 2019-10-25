package br.com.zup.beagleui.framework.view

import android.content.Context
import android.util.AttributeSet
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import android.widget.ProgressBar
import androidx.annotation.AttrRes
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import br.com.zup.beagleui.R
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Widget
import org.koin.core.KoinComponent
import org.koin.core.inject

class BeagleView(
    context: Context,
    attrs: AttributeSet?,
    @AttrRes defStyleAttr: Int
) : FrameLayout(context, attrs, defStyleAttr), KoinComponent {

    private val viewModel: BeagleUIViewModel by inject()

    private lateinit var progressBar: ProgressBar

    constructor(context: Context) : this(context, null, 0)

    constructor(context: Context, attrs: AttributeSet?): this(context, attrs, 0)

    init {
        initializeAttributes(attrs)
        createProgressBar()
    }

    private fun initializeAttributes(attrs: AttributeSet?) {
        attrs?.let {
            val attributes = context.obtainStyledAttributes(attrs, R.styleable.BeagleView)
            val contentURL = attributes.getString(R.styleable.BeagleView_bv_contentURL)
            attributes.recycle()

            contentURL?.let {
                setContentURL(contentURL)
            }
        }
    }

    private fun createProgressBar() {
        progressBar = ProgressBar(context, null, android.R.attr.progressBarStyleLarge).apply {
            isIndeterminate = true
        }

        val layoutParams = LayoutParams(32.dp(), 32.dp()).apply {
            gravity = Gravity.CENTER
        }

        addView(progressBar, layoutParams)
    }

    fun setContentURL(url: String) {
        viewModel.initialize(url)

        viewModel.state.observe(context as AppCompatActivity, Observer { state ->
            when (state) {
                is ViewState.Loading -> {
                    progressBar.visibility = if (state.value) {
                        View.VISIBLE
                    } else {
                        View.GONE
                    }
                }
                is ViewState.Error -> {
                    TODO()
                }
                is ViewState.Render -> renderWidget(state.widget)
            }
        })
    }

    private fun renderWidget(widget: Widget) {
        addView(widget.toView(context))
    }
}