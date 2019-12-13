package br.com.zup.beagle.view

import android.content.Context
import androidx.viewpager.widget.ViewPager

interface PageIndicatorOutput {

    fun swapToPage(newIndex: Int)
}

class BeaglePageView(context: Context) : ViewPager(context), PageIndicatorOutput {

    override fun swapToPage(newIndex: Int) {
        setCurrentItem(newIndex, true)
    }
}
