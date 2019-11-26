package br.com.zup.beagleui.framework.view

import android.content.Context
import android.util.AttributeSet
import android.widget.FrameLayout
import androidx.annotation.AttrRes
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagleui.framework.data.BeagleViewModel
import br.com.zup.beagleui.framework.data.ViewState
import br.com.zup.beagleui.framework.engine.renderer.ActivityRootView
import br.com.zup.beagleui.framework.engine.renderer.FragmentRootView
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Widget

sealed class BeagleViewState {
    data class Error(val throwable: Throwable) : BeagleViewState()
    object LoadStarted : BeagleViewState()
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

    private lateinit var rootView: RootView

    private val viewModel by lazy { generateViewModelInstance() }

    constructor(context: Context) : this(context, null, 0)

    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)

    fun loadView(rootView: RootView, url: String) {
        this.rootView = rootView

        loadView(url)
    }

    private fun loadView(url: String) {
        viewModel.fetchWidget(url)

        viewModel.state.observe(rootView.getLifecycleOwner(), Observer { state ->
            when (state) {
                is ViewState.Loading -> handleLoading(state.value)
                is ViewState.Error -> handleError(state.throwable)
                is ViewState.Result<*> -> renderWidget(state.data as Widget)
            }
        })
    }

    private fun handleLoading(isLoading: Boolean) {
        val state = if (isLoading) {
            BeagleViewState.LoadStarted
        } else {
            BeagleViewState.LoadFinished
        }
        stateChangedListener?.onStateChanged(state)
    }

    private fun handleError(throwable: Throwable) {
        stateChangedListener?.onStateChanged(BeagleViewState.Error(throwable))
    }

    private fun renderWidget(widget: Widget) {
        addView(widget.toView(rootView))
    }

    private fun generateViewModelInstance(): BeagleViewModel {
        return when (rootView) {
            is ActivityRootView -> {
                val activity = (rootView as ActivityRootView).activity
                ViewModelProviders.of(activity)[BeagleViewModel::class.java]
            }
            else -> {
                val fragment = (rootView as FragmentRootView).fragment
                ViewModelProviders.of(fragment)[BeagleViewModel::class.java]
            }
        }
    }
}

