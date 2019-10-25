package br.com.zup.beagleui.framework.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUIFragment : Fragment() {

    private val screenUrl: String by lazy { arguments?.getString(SCREEN_URL_KEY) ?: "" }

    companion object {
        @JvmStatic
        fun newInstance(url: String): BeagleUIFragment = BeagleUIFragment().apply {
            val bundle = Bundle()
            bundle.putString(SCREEN_URL_KEY, url)
            arguments = bundle
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return context?.let {
            BeagleView(it).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
                setContentURL(screenUrl)
            }
        }
    }
}