package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.TabItem
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.widget.ui.Text

class TabViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = TabView(
            listOf(
                buildTabView("Title 1", Text("Content")),
                buildTabView("Title 2", Button("button")),
                buildTabView(
                    title = "Title 3",
                    content =
                    Text("text").applyFlex(
                        Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        )
                    )
                ),
                buildTabView(
                    title = "Title 4",
                    content =
                    Text("text").applyFlex(
                        Flex(
                            justifyContent = JustifyContent.CENTER,
                            alignItems = Alignment.CENTER
                        )
                    )
                ),
                buildTabView(
                    title = "Title 5",
                    content =
                    Text("text").applyFlex(
                        Flex(
                            justifyContent = JustifyContent.FLEX_START,
                            alignItems = Alignment.FLEX_END
                        )
                    )
                )
            )
        )

        return context?.let { declarative.toView(this) }
    }

    private fun buildTabView(title: String, content: ServerDrivenComponent): TabItem {
        return TabItem(
            title = title,
            content = content,
            icon = "ic_launcher_foreground"
        )
    }

    companion object {
        fun newInstance(): TabViewFragment {
            return TabViewFragment()
        }
    }
}