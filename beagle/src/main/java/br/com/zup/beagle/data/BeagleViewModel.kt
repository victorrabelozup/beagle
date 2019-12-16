package br.com.zup.beagle.data

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.utils.CoroutineDispatchers
import br.com.zup.beagle.widget.core.Widget
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import java.util.Observable
import java.util.concurrent.atomic.AtomicReference

internal sealed class ViewState {
    data class Error(val throwable: Throwable) : ViewState()
    class Loading(val value: Boolean) : ViewState()
    class Result<T>(val data: T) : ViewState()
}

internal class BeagleViewModel(
    private val beagleService: BeagleService = BeagleService()
) : ViewModel(), CoroutineScope {

    private val job = Job()
    override val coroutineContext = job + CoroutineDispatchers.Main

    val state = MutableLiveData<ViewState>()
    private val urlObservableReference = AtomicReference(UrlObservable())

    fun fetchWidget(url: String) = launch {
        try {
            if (hasFetchInProgress(url)) {
                waitFetchProcess(url)
            } else {
                setLoading(url, true)
                val widget = beagleService.fetchWidget(url)

                state.value = ViewState.Result(widget)
            }
        } catch (exception: BeagleException) {
            state.value = ViewState.Error(exception)
        }
        setLoading(url, false)
    }

    private fun setLoading(url: String, loading: Boolean) {
        urlObservableReference.get().setLoading(url, loading)
        state.value = ViewState.Loading(loading)
    }

    fun fetchWidgetForCache(url: String) = launch {
        try {
            urlObservableReference.get().setLoading(url, true)
            val widget = beagleService.fetchWidget(url)
            urlObservableReference.get().notifyLoaded(url, widget)
        } catch (exception: BeagleException) {
            BeagleLogger.warning(exception.message)
        }

        urlObservableReference.get().setLoading(url, false)
    }

    @Suppress("UNCHECKED_CAST")
    private fun waitFetchProcess(url: String) {
        urlObservableReference.get().deleteObservers()
        urlObservableReference.get().addObserver { _, arg ->
            (arg as? Pair<String, Widget>)?.let {
                urlObservableReference.get().setLoading(url, false)
                if (url == it.first)
                    state.value = ViewState.Result(it)
            }
        }
    }

    private fun hasFetchInProgress(url: String) =
        urlObservableReference.get().hasUrl(url)

    fun fetchAction(url: String) = launch {
        state.value = ViewState.Loading(true)

        try {
            val action = beagleService.fetchAction(url)
            state.value = ViewState.Result(action)
        } catch (exception: BeagleException) {
            state.value = ViewState.Error(exception)
        }

        state.value = ViewState.Loading(false)
    }

    public override fun onCleared() {
        cancel()
    }

    //TODO Refactor this to use coroutines flow
    private class UrlObservable : Observable() {
        private var urlInLoadList = mutableListOf<String>()

        fun hasUrl(url: String) = urlInLoadList.contains(url)

        fun setLoading(url: String, loading: Boolean) {
            if (loading)
                urlInLoadList.add(url)
            else
                urlInLoadList.remove(url)
        }

        fun notifyLoaded(url: String, widget: Widget) {
            urlInLoadList.remove(url)
            val pair = url to widget
            notifyObservers(pair)
        }
    }
}



