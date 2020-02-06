package br.com.zup.beagle.data

import br.com.zup.beagle.data.serializer.BeagleSerializer
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
    private var beagleSerialize = BeagleSerializer()

    internal fun init(service: BeagleService, serialize: BeagleSerializer) {
        beagleService = service
        beagleSerialize = serialize
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

    fun serializeWidget(widget: Widget): String {
        return beagleSerialize.serializeWidget(widget)
    }

    fun deserializeWidget(response: String): Widget {
        return beagleSerialize.deserializeWidget(response)
    }
}
