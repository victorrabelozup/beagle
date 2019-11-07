package br.com.zup.beagleui.framework.view

import android.content.Context
import android.util.AttributeSet
import android.widget.FrameLayout
import androidx.annotation.AttrRes
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagleui.framework.data.BeagleViewModel
import br.com.zup.beagleui.framework.data.ViewState
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Widget

sealed class BeagleViewState {
    object Error : BeagleViewState()
    object LoadStated : BeagleViewState()
    object LoadFinished : BeagleViewState()
}

interface StateChangedListener {
    fun onStateChanged(state: BeagleViewState)
}

internal class BeagleView(
    context: Context,
    attrs: AttributeSet?,
    @AttrRes defStyleAttr: Int
) : FrameLayout(context, attrs, defStyleAttr) {

    var stateChangedListener: StateChangedListener? = null

    private var fragment: Fragment? = null
    private var activity: FragmentActivity? = null
    private var viewLifecycleOwner: LifecycleOwner? = null

    private val viewModel by lazy { generateViewModelInstance() }

    constructor(context: Context) : this(context, null, 0)

    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)

    fun loadView(activity: AppCompatActivity, url: String) {
        this.activity = activity
        this.viewLifecycleOwner = activity

        loadView(url)
    }

    fun loadView(fragment: Fragment, url: String) {
        this.fragment = fragment
        this.viewLifecycleOwner = fragment.viewLifecycleOwner

        loadView(url)
    }

    private fun loadView(url: String) {
        viewModel.fetchWidget(url)

        viewLifecycleOwner?.let {
            viewModel.state.observe(it, Observer { state ->
                when (state) {
                    is ViewState.Loading -> handleLoading(state.value)
                    is ViewState.Error -> handleError()
                    is ViewState.Result<*> -> renderWidget(state.data as Widget)
                }
            })
        }
    }

    private fun handleLoading(isLoading: Boolean) {
        val state = if (isLoading) {
            BeagleViewState.LoadStated
        } else {
            BeagleViewState.LoadFinished
        }
        stateChangedListener?.onStateChanged(state)
    }

    private fun handleError() {
        stateChangedListener?.onStateChanged(BeagleViewState.Error)
    }

    private fun renderWidget(widget: Widget) {
        addView(widget.toView(context))
    }

    private fun generateViewModelInstance(): BeagleViewModel {
        return fragment?.let {
            ViewModelProviders.of(it)[BeagleViewModel::class.java]
        } ?: activity?.let {
            ViewModelProviders.of(it)[BeagleViewModel::class.java]
        } ?: run {
            throw IllegalStateException("You should call loadView with a fragment or activity instance.")
        }
    }
}

