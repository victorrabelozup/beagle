package br.com.zup.beagle.view

import android.content.Context
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagle.data.BeagleViewModel
import br.com.zup.beagle.data.ViewState
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.utils.implementsGenericTypeOf
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Widget

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

    private val observer = Observer<ViewState> { state ->
        handleResponse(state)
    }

    private lateinit var rootView: RootView
    private var view: View? = null

    private val viewModel by lazy { generateViewModelInstance() }

    fun loadView(rootView: RootView, url: String) {
        loadView(rootView, url, null)
    }

    fun updateView(rootView: RootView, url: String, view: View) {
        loadView(rootView, url, view)
    }

    private fun loadView(rootView: RootView, url: String, view: View?) {
        this.view = view
        this.rootView = rootView
        viewModel.state.removeObserver { observer }
        viewModel.state.observe(rootView.getLifecycleOwner(), observer)

        viewModel.fetchWidget(url)

    }

    private fun handleResponse(
        state: ViewState?) {
        when (state) {
            is ViewState.Loading -> handleLoading(state.value)
            is ViewState.Error -> handleError(state.throwable)
            is ViewState.Result<*> -> renderWidget(state.data as Widget, view)
        }
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
            removeAllViewsInLayout()
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

