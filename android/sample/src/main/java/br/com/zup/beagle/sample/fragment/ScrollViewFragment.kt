package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text

class ScrollViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            content = ScrollView(
                scrollDirection = ScrollAxis.HORIZONTAL,
                children = listOf(
                    Text("Text")
                        .applyAppearance(Appearance(backgroundColor = "#888888"))
                        .applyFlex(
                            Flex(
                                margin = EdgeValue(
                                    left = UnitValue(30.0, UnitType.REAL)
                                )
                            )
                        ),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text"),
                    Text("Text")
                )
            )
        )

        return context?.let { declarative.toView(this) }
    }

    companion object {

        fun newInstance(): ScrollViewFragment {
            return ScrollViewFragment()
        }
    }
}