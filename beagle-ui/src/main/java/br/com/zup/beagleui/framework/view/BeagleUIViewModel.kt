package br.com.zup.beagleui.framework.view

import androidx.lifecycle.MutableLiveData
import br.com.zup.beagleui.framework.base.BaseViewModel
import br.com.zup.beagleui.framework.data.repository.BeagleDataRepository
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.launch

internal sealed class ViewState {
    class Loading(val value: Boolean) : ViewState()
    object Error : ViewState()
    class Render(val widget: Widget) : ViewState()
}

internal class BeagleUIViewModel(
    private val beagleDataRepository: BeagleDataRepository
) : BaseViewModel() {

    val state = MutableLiveData<ViewState>()

    private lateinit var screenUrl: String

    fun initialize(screenUrl: String) {
        this.screenUrl = screenUrl

        getScreenScheme()
    }

    private fun getScreenScheme() = launch {
        state.value = ViewState.Loading(true)

        try {
            val widget = beagleDataRepository.fetchWidget(screenUrl)
            state.value = ViewState.Render(widget)
        } catch (exception: BeagleDataException) {
            state.value = ViewState.Error
        }

        state.value = ViewState.Loading(false)
    }
}



