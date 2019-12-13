package br.com.zup.beagle.view

import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.utils.dp

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUIFragment : Fragment(), StateChangedListener {

    private val screenUrl: String by lazy { arguments?.getString(SCREEN_URL_KEY) ?: "" }

    private lateinit var progressBar: ProgressBar

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
            FrameLayout(it).apply {
                createBeagleView(this)
                createProgressBar(this)
            }
        }
    }

    private fun createBeagleView(view: ViewGroup) {
        view.addView(BeagleView(view.context).apply {
            stateChangedListener = this@BeagleUIFragment
            layoutParams = ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
            loadView(FragmentRootView(this@BeagleUIFragment), screenUrl)
        })
    }

    private fun createProgressBar(view: ViewGroup) {
        progressBar = ProgressBar(context, null, android.R.attr.progressBarStyleLarge).apply {
            isIndeterminate = true
        }

        val layoutParams = FrameLayout.LayoutParams(32.dp(), 32.dp()).apply {
            gravity = Gravity.CENTER
        }

        view.addView(progressBar, layoutParams)
    }

    override fun onStateChanged(state: BeagleViewState) {
        when (state) {
            is BeagleViewState.Error -> {
                state.throwable.printStackTrace()
                Toast.makeText(
                    context,
                    "Something went wrong! ",
                    Toast.LENGTH_SHORT
                ).show()
            }
            is BeagleViewState.LoadStarted -> progressBar.visibility = View.VISIBLE
            is BeagleViewState.LoadFinished -> progressBar.visibility = View.GONE
        }
    }
}