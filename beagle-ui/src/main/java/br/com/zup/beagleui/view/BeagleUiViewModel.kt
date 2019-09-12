package br.com.zup.beagleui.view

import androidx.lifecycle.MutableLiveData
import br.com.zup.beagleui.core.BaseViewModel
import br.com.zup.beagleui.data.BeagleHttpClient
import br.com.zup.beagleui.engine.framework.core.Widget
import kotlinx.coroutines.launch
import java.lang.Exception

internal class BeagleUiViewModel(
    private val beagleHttpClient: BeagleHttpClient
) : BaseViewModel() {

    val widgetToRender = MutableLiveData<Widget>()

    private lateinit var screenUrl: String

    fun initialize(screenUrl: String) {
        this.screenUrl = screenUrl

        getScreenScheme()
    }

    private fun getScreenScheme() = launch {
        try {
            val widget = beagleHttpClient.fetchWidget(screenUrl)
            widgetToRender.value = widget
        } catch (exception: Exception) {

        }
    }
}
