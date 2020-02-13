package br.com.zup.beagle.data.serializer

import br.com.zup.beagle.data.serializer.adapter.ActionJsonAdapterFactory
import br.com.zup.beagle.data.serializer.adapter.AndroidFrameworkIgnoreAdapterFactory
import br.com.zup.beagle.data.serializer.adapter.ComponentJsonAdapterFactory
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

internal object BeagleMoshi {

    val moshi: Moshi by lazy {
        Moshi.Builder()
            .add(AndroidFrameworkIgnoreAdapterFactory())
            .add(ComponentJsonAdapterFactory.make())
            .add(ActionJsonAdapterFactory.make())
            .add(KotlinJsonAdapterFactory())
            .build()
    }
}
