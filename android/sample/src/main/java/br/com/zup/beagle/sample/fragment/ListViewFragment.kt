package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.EdgeValue
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.ui.ListDirection
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.Text

class ListViewFragment : Fragment() {

    private val flex = Flex(margin = EdgeValue(all = UnitValue(20.0, UnitType.REAL)))

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Container(
            children = listOf(
                ListView(direction = ListDirection.HORIZONTAL,
                    rows = listOf(
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

        fun newInstance(): ListViewFragment {
            return ListViewFragment()
        }
    }
}