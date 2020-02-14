package br.com.zup.beagle.view

import android.content.Context
import androidx.viewpager.widget.ViewPager
import br.com.zup.beagle.widget.pager.PageIndicatorOutput

class BeaglePageView(context: Context) : ViewPager(context), PageIndicatorOutput {

    override fun swapToPage(newIndex: Int) {
        setCurrentItem(newIndex, true)
    }
}
