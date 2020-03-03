package br.com.zup.beagle.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.data.serializer.BeagleSerializer
import br.com.zup.beagle.utils.applyBackgroundFromWindowBackgroundTheme
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.ui.UndefinedWidget

private val beagleSerializer: BeagleSerializer = BeagleSerializer()
private const val JSON_SCREEN_KEY = "JSON_SCREEN_KEY"

internal class BeagleFragment : Fragment() {

    private val screen: ServerDrivenComponent by lazy {
        val json = arguments?.getString(JSON_SCREEN_KEY) ?: beagleSerializer.serializeComponent(UndefinedWidget())
        beagleSerializer.deserializeComponent(json)
    }

    companion object {
        @JvmStatic
        fun newInstance(component: ServerDrivenComponent) = newInstance(
            beagleSerializer.serializeComponent(component)
        )

        @JvmStatic
        fun newInstance(json: String): BeagleFragment = BeagleFragment().apply {
            val bundle = Bundle()
            bundle.putString(JSON_SCREEN_KEY, json)
            arguments = bundle
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return context?.let {
            FrameLayout(it).apply {
                applyBackgroundFromWindowBackgroundTheme(it, activity?.theme)
                addView(screen.toView(context))
            }
        }
    }
}
