package br.com.zup.beagleui.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.sample.widgets.TextField

class TextFieldFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Container(
            content = TextField(
                hint = "Hint",
                color = "#000000"
            )
        )
        return declarative.toView(this)
    }

    companion object {
        fun newInstance(): TextFieldFragment {
            return TextFieldFragment()
        }
    }
}