package br.com.zup.beagleui.framework.view

import android.content.Context
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagleui.framework.data.BeagleViewModel
import br.com.zup.beagleui.framework.data.ViewState
import br.com.zup.beagleui.framework.engine.renderer.ActivityRootView
import br.com.zup.beagleui.framework.engine.renderer.FragmentRootView
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.utils.implementsGenericTypeOf
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
    context: Context
) : BeagleFlexView(context) {

    var stateChangedListener: StateChangedListener? = null

    private lateinit var rootView: RootView

    private val viewModel by lazy { generateViewModelInstance() }

    fun loadView(rootView: RootView, url: String) {
        loadView(rootView, url, null)
    }

    fun updateView(rootView: RootView, url: String, view: View) {
        loadView(rootView, url, view)
    }

    private fun loadView(rootView: RootView, url: String, view: View?) {
        this.rootView = rootView

        viewModel.fetchWidget(url)

        viewModel.state.observe(rootView.getLifecycleOwner(), Observer { state ->
            when (state) {
                is ViewState.Loading -> handleLoading(state.value)
                is ViewState.Error -> handleError(state.throwable)
                is ViewState.Result<*> -> renderWidget(state.data as Widget, view)
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

    private fun renderWidget(widget: Widget, view: View? = null) {
        if (view != null) {
            if (view.implementsGenericTypeOf(OnStateUpdatable::class.java, widget::class.java)) {
                (view as? OnStateUpdatable<Widget>)?.onUpdateState(widget)
            } else {
                val widgetView = widget.toView(rootView)
                removeView(view)
                addView(widgetView)
            }
        } else {
            val widgetView = widget.toView(rootView)
            addView(widgetView)
        }
    }

    private fun generateViewModelInstance(): BeagleViewModel {
        return when (rootView) {
            is ActivityRootView -> {
                val activity = (rootView as ActivityRootView).activity
                ViewModelProviders.of(activity)[BeagleViewModel::class.java]
            } else -> {
                val fragment = (rootView as FragmentRootView).fragment
                ViewModelProviders.of(fragment)[BeagleViewModel::class.java]
            }
        }
    }
}

