package br.com.zup.beagleui.framework.data.repository

import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

internal class BeagleDataRepository(private val beagleHttpClient: BeagleHttpClient) {

    @Throws(BeagleDataException::class)
    suspend fun fetchWidget(url: String): Widget = withContext(Dispatchers.IO) {
        //TODO implement below the cache
        // val hasCache = cacheHelper.hasCache(url)
        //if(hasCache) return cacheHelper.fetchWidget(url)
        val widget = beagleHttpClient.fetchWidget(url)
        //if(!hasCache) cacheHelper.saveCache(url, widget)
        return@withContext widget
    }
}