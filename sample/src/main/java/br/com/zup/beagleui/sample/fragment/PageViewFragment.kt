package br.com.zup.beagleui.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.layout.FlexSingleWidget
import br.com.zup.beagleui.framework.widget.layout.PageView
import br.com.zup.beagleui.framework.widget.ui.PageIndicator
import br.com.zup.beagleui.framework.widget.ui.Text

class PageViewFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = PageView(
            pageIndicator = PageIndicator(
                selectedColor = "#FFFFFF",
                unselectedColor = "#888888"
            ),
            pages = listOf(
                FlexSingleWidget(
                    flex = Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    ),
                    child = Text("Page 1")
                ),
                FlexSingleWidget(
                    flex = Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    ),
                    child = Text("Page 2")
                ),
                FlexSingleWidget(
                    flex = Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    ),
                    child = Text("Page 3")
                ),
                FlexSingleWidget(
                    flex = Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    ),
                    child = Text("Page 4")
                ),
                FlexSingleWidget(
                    flex = Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    ),
                    child = Text("Page 5")
                )
            )
        )

        return context?.let { declarative.toView(this) }
    }

    companion object {

        fun newInstance(): PageViewFragment {
            return PageViewFragment()
        }
    }
}