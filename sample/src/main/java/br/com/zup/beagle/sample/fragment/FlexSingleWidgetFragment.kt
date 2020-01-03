package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Text

class FlexSingleWidgetFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val declarative = Screen(
            content =
            FlexSingleWidget(
                flex = Flex(
                    flexDirection = FlexDirection.ROW,
                    grow = 1.0
                ),
                child =
                Text("Texto")
                , appearance = Appearance(backgroundColor = "#D81B60")
            )
        )

        return context?.let { declarative.toView(this) }
    }

    companion object {

        fun newInstance(): FlexSingleWidgetFragment {
            return FlexSingleWidgetFragment()
        }
    }
}