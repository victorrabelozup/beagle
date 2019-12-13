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
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.RemoteState
import br.com.zup.beagle.widget.layout.RemoteUpdatableWidget
import br.com.zup.beagle.widget.layout.StatefulWidget
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.sample.widgets.TextField

class RemoteStatefulFragment : Fragment() {

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
                    children = buildChildren()
                )
            )
        )

        return declarative.toView(this)
    }

    private fun buildChildren(): List<Widget> {
        return listOf(
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = Button(text = "Click"),
                    updateStates = listOf(
                        UpdatableState(
                            targetId = "txt3",
                            remoteState = RemoteState()
                        )
                    )
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            ),
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = TextField(description = "5de80ce52f00008400c023ab"),
                    id = "txt2"
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            ),
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = RemoteUpdatableWidget(
                        url = "http://www.mocky.io/v2/#{txt2.value}",
                        initialState = TextField(description = "Select..")
                    ),
                    id = "txt3"
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            )
        )
    }

    companion object {

        fun newInstance(): RemoteStatefulFragment {
            return RemoteStatefulFragment()
        }
    }
}