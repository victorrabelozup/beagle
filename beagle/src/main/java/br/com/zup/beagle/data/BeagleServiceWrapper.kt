package br.com.zup.beagle.data

import br.com.zup.beagle.widget.core.Widget
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

interface FetchWidgetListener {

    fun onSuccess(widget: Widget)
    fun onError(error: Throwable)
}

class BeagleServiceWrapper {

    private val job = Job()
    private val scope = CoroutineScope(Dispatchers.Main + job)
    private var beagleService = BeagleService()

    internal fun init(service: BeagleService) {
        beagleService = service
    }

    fun fetchWidget(url: String, listener: FetchWidgetListener) {
        scope.launch {
            try {
                listener.onSuccess(beagleService.fetchWidget(url))
            } catch (e: Throwable) {
                listener.onError(e)
            }
        }
    }
}
