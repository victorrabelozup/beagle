package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class TabViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = TabView(
            listOf(
                TabItem(
                    title = "Title 1",
                    content = Text("text"),
                    icon = "ic_launcher_foreground"
                ),
                TabItem(
                    title = "Title 2",
                    content = Button("button"),
                    icon = "ic_launcher_background"
                ),
                TabItem(
                    title = "Title 3",
                    content = FlexSingleWidget(
                        flex = Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        ),
                        child = Text("text")
                    ),
                    icon = "indicator_default"
                ),
                TabItem(
                    title = "Title 4",
                    content = FlexSingleWidget(
                        flex = Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        ),
                        child = Button("button")
                    ),
                    icon = "ic_launcher_background"
                ),
                TabItem(
                    title = "Title 5",
                    content = FlexSingleWidget(
                        flex = Flex(
                            justifyContent = JustifyContent.FLEX_START,
                            alignItems = Alignment.FLEX_END
                        ),
                        child = Text("text")
                    ),
                    icon = "indicator_default"
                ),
                TabItem(
                    title = "Title 6",
                    content = FlexSingleWidget(
                        flex = Flex(
                            justifyContent = JustifyContent.FLEX_START,
                            alignItems = Alignment.FLEX_END
                        ),
                        child = Button("button")
                    ),
                    icon = "ic_launcher_foreground"
                )
            )
        )
        return context?.let { declarative.toView(this) }
    }

    companion object {
        fun newInstance(): TabViewFragment {
            return TabViewFragment()
        }
    }
}