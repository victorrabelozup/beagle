package br.com.zup.beagle.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.R
import br.com.zup.beagle.setup.BeagleEnvironment

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
        BeagleEnvironment.designSystem?.let {
            setTheme(it.theme())
        }

        super.onCreate(savedInstanceState)

        supportActionBar?.hide()

        setContentView(buildContent())

        BeagleNavigator.addScreen(this, screenUrl)
    }

    private fun buildContent() = FrameLayout(this).apply {
        id = R.id.beagle_content
        layoutParams = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )
        if (this@BeagleUIActivity.supportActionBar == null) {
            addView(createToolbar())
        }
    }

    private fun createToolbar(): Toolbar {
        return Toolbar(this).apply {
            setSupportActionBar(this)
            setNavigationOnClickListener {
                BeagleNavigator.pop(context)
            }
        }
    }

    override fun onBackPressed() {
        if (supportFragmentManager.backStackEntryCount == 1) {
            finish()
        } else {
            super.onBackPressed()
        }
    }

    // If ActionBar is present on Theme then set the back button action
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            android.R.id.home -> {
                onBackPressed()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }
}
