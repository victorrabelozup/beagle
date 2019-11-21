package br.com.zup.beagleui.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Alignment
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.FlexDirection
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableEvent
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text

class StatefulFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val declarative = Container(
            content =
            StatefulWidget(
                child = FlexWidget(
                    flex = Flex(
                        flexDirection = FlexDirection.COLUMN,
                        justifyContent = JustifyContent.CENTER,
                        alignItems = Alignment.CENTER,
                        alignContent = Alignment.SPACE_BETWEEN,
                        grow = 1.0
                    ),
                    children = listOf(
                        UpdatableWidget(
                            child = Button("Click to update"),
                            updatableEvent = UpdatableEvent.ON_CLICK,
                            updateIds = listOf("txt1")
                        ),
                        UpdatableWidget(
                            child = Text("Default Text1", style = "DesignSystem.Text.H2"),
                            id = "txt1"
                        ),
                        UpdatableWidget(
                            child = Text("Default Text2", style = "DesignSystem.Text.H2"),
                            id = "txt2"
                        ),
                        Text("Default Text3", style = "DesignSystem.Text.H2")
                    )
                )
            )
        )

        return context?.let { declarative.toView(it) }
    }

    companion object {

        fun newInstance(): StatefulFragment {
            return StatefulFragment()
        }
    }
}