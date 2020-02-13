package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScrollAxis
import br.com.zup.beagle.widget.layout.ScrollView
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class ScrollViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val declarative = Screen(
            header = Button(text = "Top"),
            footer = Button(text = "Bottom"),
            content = ScrollView(
                scrollDirection = ScrollAxis.HORIZONTAL,
                children = listOf(
                    Container(
                        children = listOf(
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto"),
                            Text("Texto")
                        )
                    ).applyFlex(
                        Flex(
                            flexDirection = FlexDirection.ROW
                        )
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