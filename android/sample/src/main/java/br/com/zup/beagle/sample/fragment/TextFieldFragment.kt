package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.sample.widgets.TextField
import br.com.zup.beagle.widget.layout.Screen


class TextFieldFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            child = TextField(
                hint = "Hint",
                color = "FFB6C1"
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