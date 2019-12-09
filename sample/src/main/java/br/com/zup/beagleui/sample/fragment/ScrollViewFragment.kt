package br.com.zup.beagleui.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.ScrollAxis
import br.com.zup.beagleui.framework.widget.layout.ScrollView
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text

class ScrollViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val declarative = Container(
            header = Button(text = "Top"),
            footer = Button(text = "Bottom"),
            content = ScrollView(
                scrollDirection = ScrollAxis.HORIZONTAL,
                children = listOf(
                    FlexWidget(
                        flex = Flex(
                            flexDirection = FlexDirection.ROW
                        ),
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