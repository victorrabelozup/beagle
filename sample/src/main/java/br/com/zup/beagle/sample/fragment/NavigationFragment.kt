package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
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
import br.com.zup.beagle.widget.navigation.Navigator
import br.com.zup.beagle.widget.ui.Button

class NavigationFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Container(
            content =
            FlexWidget(
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

        return declarative.toView(this)
    }

    private fun buildChildren(): List<Widget> {
        return listOf(
            FlexSingleWidget(
                child = Navigator(
                    child = Button(text = "Click to navigate"),
                    action = Navigate(
                        type = NavigationType.ADD_VIEW,
                        path = "https://t001-2751a.firebaseapp.com/flow/step1.json"
                    )
                ),
                flex = Flex(size = Size(width = UnitValue(80.0, UnitType.PERCENT)))
            )
        )
    }

    companion object {
        fun newInstance(): NavigationFragment {
            return NavigationFragment()
        }
    }
}