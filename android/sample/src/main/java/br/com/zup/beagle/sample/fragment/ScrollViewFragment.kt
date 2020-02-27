package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Text

class ScrollViewFragment : Fragment() {

    private val flex = Flex(padding = EdgeValue(all = UnitValue(50.0, UnitType.REAL)))

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Container(
            children = listOf(
                Text("1 Text\n2 Text\n3 Text\n4 Text\n5 Text\n6 Text\n7 Text\n8 Text\n9 Text\n10 Text.").applyFlex(
                    Flex(shrink = 1.0, size = Size(height = UnitValue(200.0, UnitType.REAL)))),
                ScrollView(
                    scrollDirection = ScrollAxis.VERTICAL,
                    children = listOf(
                        Text("Text 1").applyFlex(flex),
                        Text("Text 2").applyFlex(flex),
                        Text("Text 3").applyFlex(flex),
                        Text("Text 4").applyFlex(flex),
                        Text("Text 5").applyFlex(flex),
                        Text("Text 6").applyFlex(flex),
                        Text("Text 7").applyFlex(flex),
                        Text("Text 8").applyFlex(flex),
                        Text("Text 9").applyFlex(flex),
                        Text("Text 10").applyFlex(flex)
                    )
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