package br.com.zup.beagle.data.deserializer

import br.com.zup.beagle.data.deserializer.adapter.ActionJsonAdapterFactory
import br.com.zup.beagle.data.deserializer.adapter.AndroidFrameworkIgnoreAdapterFactory
import br.com.zup.beagle.data.deserializer.adapter.WidgetJsonAdapterFactory
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

internal object BeagleMoshi {

    val moshi: Moshi by lazy {
        Moshi.Builder()
            .add(AndroidFrameworkIgnoreAdapterFactory())
            .add(WidgetJsonAdapterFactory.make())
            .add(ActionJsonAdapterFactory.make())
            .add(KotlinJsonAdapterFactory())
            .build()
    }
}
