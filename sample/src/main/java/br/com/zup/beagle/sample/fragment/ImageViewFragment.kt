package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.CornerRadius
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.NetworkImage

class ImageViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            content = FlexSingleWidget(
                child = NetworkImage(
                    url = "https://cdn-images-1.medium.com/max/1200/1*kjiNJPB3Y-ZVmjxco_bORA.png",
                    appearance = Appearance(
                        cornerRadius = CornerRadius(25.0)
                    )
                ),
                flex = Flex(
                    size = Size(
                        height = UnitValue(300.0, UnitType.REAL),
                        width = UnitValue(300.0, UnitType.REAL)
                    )
                )
            )
        )
        return declarative.toView(this)
    }

    companion object {
        fun newInstance(): ImageViewFragment {
            return ImageViewFragment()
        }
    }
}