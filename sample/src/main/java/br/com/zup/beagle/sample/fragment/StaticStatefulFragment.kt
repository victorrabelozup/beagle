package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Alignment
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.StatefulWidget
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Text

class StaticStatefulFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val declarative = Screen(
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
                            updateStates = listOf(
                                UpdatableState(
                                    targetId = "txt1",
                                    staticState = Text("Draw a racket 1")
                                ),
                                UpdatableState(
                                    targetId = "txt2",
                                    staticState = Text("Draw a racket 2")
                                )
                            )
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
        return declarative.toView(this)
    }

    companion object {

        fun newInstance(): StaticStatefulFragment {
            return StaticStatefulFragment()
        }
    }
}