package br.com.zup.beagleui.framework.data

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.zup.beagleui.framework.utils.CoroutineDispatchers
import br.com.zup.beagleui.framework.exception.BeagleDataException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

internal sealed class ViewState {
    object Error : ViewState()
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
        } catch (exception: BeagleDataException) {
            state.value = ViewState.Error
        }

        state.value = ViewState.Loading(false)
    }

    fun fetchAction(url: String) = launch {
        state.value = ViewState.Loading(true)

        try {
            val action = beagleService.fetchAction(url)
            state.value = ViewState.Result(action)
        } catch (exception: BeagleDataException) {
            state.value = ViewState.Error
        }

        state.value = ViewState.Loading(false)
    }

    public override fun onCleared() {
        cancel()
    }
}



