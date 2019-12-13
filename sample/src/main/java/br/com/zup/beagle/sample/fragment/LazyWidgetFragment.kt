package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.lazy.LazyWidget
import br.com.zup.beagle.widget.ui.Text

class LazyWidgetFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = LazyWidget(
            url = "http://www.mocky.io/v2/5dde6da5310000d2253ae1f1",
            initialState = Text("Loading..")
        )
        return declarative.toView(this)
    }

    companion object {
        fun newInstance(): LazyWidgetFragment {
            return LazyWidgetFragment()
        }
    }
}
