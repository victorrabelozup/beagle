package br.com.zup.beagleui.framework.view

import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.utils.dp

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
            BeagleView(it).apply {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
                loadView(this@BeagleUIFragment, screenUrl)
                createProgressBar(this)
                stateChangedListener = this@BeagleUIFragment
            }
        }
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