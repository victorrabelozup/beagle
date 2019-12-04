package br.com.zup.beagleui.framework.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagleui.R

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUIActivity : AppCompatActivity() {

    private val screenUrl: String by lazy { intent.extras?.getString(SCREEN_URL_KEY) ?: "" }

    companion object {
        fun newIntent(context: Context, url: String): Intent {
            return Intent(context, BeagleUIActivity::class.java).apply {
                putExtra(SCREEN_URL_KEY, url)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(buildContent())

        BeagleNavigator.addScreen(this, screenUrl)
    }

    private fun buildContent() = FrameLayout(this).apply {
        id = R.id.beagle_content
        layoutParams = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )
    }

    override fun onBackPressed() {
        if (supportFragmentManager.backStackEntryCount == 1) {
            finish()
        } else {
            super.onBackPressed()
        }
    }
}
