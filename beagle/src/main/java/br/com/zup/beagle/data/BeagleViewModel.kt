package br.com.zup.beagle.data

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.utils.CoroutineDispatchers
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

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

    fun fetchWidget(url: String) = launch {

        state.value = ViewState.Loading(true)

        try {
            val widget = beagleService.fetchWidget(url)
            state.value = ViewState.Result(widget)
        } catch (exception: BeagleException) {
            state.value = ViewState.Error(exception)
        }

        state.value = ViewState.Loading(false)

    }

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
}



