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
import br.com.zup.beagle.widget.layout.DynamicState
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.FlexWidget
import br.com.zup.beagle.widget.layout.StatefulWidget
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.sample.widgets.TextField

class DynamicStatefulFragment : Fragment() {

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
                            dynamicState = DynamicState(
                                originId = "txt2",
                                stateOriginField = "value",
                                targetField = "description"
                            )
                        )
                    )
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            ),
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = TextField(description = "Default Text2"),
                    id = "txt2",
                    updateStates = listOf(
                        UpdatableState(
                            targetId = "txt4",
                            dynamicState = DynamicState(
                                originId = "this",
                                stateOriginField = "value",
                                targetField = "description"
                            )
                        )
                    )
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            ),
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = TextField(description = "Default Text3"),
                    id = "txt3"
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            ),
            FlexSingleWidget(
                child = UpdatableWidget(
                    child = TextField(description = "Default Text4"),
                    id = "txt4"
                ), flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            )
        )
    }

    companion object {

        fun newInstance(): DynamicStatefulFragment {
            return DynamicStatefulFragment()
        }
    }
}