package br.com.zup.beagle.widget.pager

import br.com.zup.beagle.widget.core.ViewConvertable

interface PageIndicatorWidget : ViewConvertable {
    fun setCount(pages: Int)
    fun onItemUpdated(newIndex: Int)
    fun initPageView(pageIndicatorOutput: PageIndicatorOutput)
}