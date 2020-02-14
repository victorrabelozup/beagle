package br.com.zup.beagle.data.cache

import br.com.zup.beagle.core.ServerDrivenComponent

internal object BeagleCacheHelper {
    private val cacheMap = mutableMapOf<String, ServerDrivenComponent>()

    fun cache(
        url: String,
        obj: ServerDrivenComponent
    ): ServerDrivenComponent {
        cacheMap[url] = obj

        return obj
    }

    fun getFromCache(url: String) = cacheMap.containsKey(url).let {
        cacheMap[url]
    }
}