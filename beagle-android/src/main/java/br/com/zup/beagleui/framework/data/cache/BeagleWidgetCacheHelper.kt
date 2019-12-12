package br.com.zup.beagleui.framework.data.cache

import br.com.zup.beagleui.framework.widget.core.Widget

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