package br.com.zup.beagle.sample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.CornerRadius
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Size
import br.com.zup.beagle.widget.core.UnitType
import br.com.zup.beagle.widget.core.UnitValue
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.NetworkImage

class ImageViewFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val declarative = Screen(
            content =
            NetworkImage(
                path = "https://cdn-images-1.medium.com/max/1200/1*kjiNJPB3Y-ZVmjxco_bORA.png"
            ).applyFlex<NetworkImage>(
                Flex(
                    size = Size(
                        height = UnitValue(300.0, UnitType.REAL),
                        width = UnitValue(300.0, UnitType.REAL)
                    )
                )
            ).applyAppearance<NetworkImage>(
                Appearance(
                    cornerRadius = CornerRadius(25.0)
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