package br.com.zup.beagle.data.cache

import br.com.zup.beagle.widget.core.Widget

internal class BeagleWidgetCacheHelper {
    private val widgetCacheMap = mutableMapOf<String, Widget>()
    fun cacheWidget(
        url: String,
        widget: Widget
    ): Widget {

        widgetCacheMap[url] = widget

        return widget
    }

    fun getWidgetFromCache(url: String) =
        widgetCacheMap.containsKey(url).let { widgetCacheMap[url] }
}