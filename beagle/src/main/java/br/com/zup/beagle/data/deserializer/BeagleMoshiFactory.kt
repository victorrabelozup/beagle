package br.com.zup.beagle.data.deserializer

import br.com.zup.beagle.data.deserializer.adapter.ActionJsonAdapterFactory
import br.com.zup.beagle.data.deserializer.adapter.WidgetJsonAdapterFactory
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

internal class BeagleMoshiFactory(
    private val widgetJsonAdapterFactory: WidgetJsonAdapterFactory = WidgetJsonAdapterFactory(),
    private val actionJsonAdapterFactory: ActionJsonAdapterFactory = ActionJsonAdapterFactory()
) {

    fun make(): Moshi {
        return Moshi.Builder()
            .add(widgetJsonAdapterFactory.make())
            .add(actionJsonAdapterFactory.make())
            .add(KotlinJsonAdapterFactory())
            .build()
    }
}
