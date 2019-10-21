package br.com.zup.beagleui.framework.view

import androidx.lifecycle.MutableLiveData
import br.com.zup.beagleui.framework.base.BaseViewModel
import br.com.zup.beagleui.framework.data.repository.BeagleDataRepository
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.launch

internal class BeagleUiViewModel(
    private val beagleDataRepository: BeagleDataRepository
) : BaseViewModel() {

    val widgetToRender = MutableLiveData<Widget>()

    private lateinit var screenUrl: String

    fun initialize(screenUrl: String) {
        this.screenUrl = screenUrl

        getScreenScheme()
    }

    private fun getScreenScheme() = launch {
        try {
            val widget = beagleDataRepository.fetchWidget(screenUrl)
            widgetToRender.value = widget
        } catch (exception: BeagleDataException) {
            print(exception)
        }
    }
}
