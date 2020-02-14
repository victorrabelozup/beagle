package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.PageView
import br.com.zup.beagle.widget.pager.PageIndicator
import br.com.zup.beagle.widget.ui.Text

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
                Text("Page 1").applyFlex(
                    Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    )
                ),
                Text("Page 2").applyFlex(
                    Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    )
                ),
                Text("Page 3").applyFlex(
                    Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    )
                ),
                Text("Page 4").applyFlex(
                    Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    )
                ),
                Text("Page 5").applyFlex(
                    Flex(
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER
                    )
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