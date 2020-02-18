package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.layout.Stack
import br.com.zup.beagle.widget.ui.Text

class StackViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Stack(
            children = listOf(
                Text("Text 1"),
                Text("Text 2"),
                Text("Text 3")
            )
        )

        return context?.let { declarative.toView(this) }
    }

    companion object {

        fun newInstance(): StackViewFragment {
            return StackViewFragment()
        }
    }
}
