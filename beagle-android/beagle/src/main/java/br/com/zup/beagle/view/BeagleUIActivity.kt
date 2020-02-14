package br.com.zup.beagle.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import android.util.TypedValue
import android.view.View
import android.widget.LinearLayout
import br.com.zup.beagle.R
import br.com.zup.beagle.setup.BeagleEnvironment

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUIActivity : AppCompatActivity() {

    private val screenUrl: String by lazy { intent.extras?.getString(SCREEN_URL_KEY) ?: "" }
    private val defaultLayoutParams = ViewGroup.LayoutParams(
        ViewGroup.LayoutParams.MATCH_PARENT,
        ViewGroup.LayoutParams.MATCH_PARENT
    )

    companion object {
        fun newIntent(context: Context, url: String): Intent {
            return Intent(context, BeagleUIActivity::class.java).apply {
                putExtra(SCREEN_URL_KEY, url)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        BeagleEnvironment.beagleSdk.designSystem?.let {
            setTheme(it.theme())
        }

        super.onCreate(savedInstanceState)

        setContentView(buildContent(), defaultLayoutParams)

        if (supportActionBar == null) {
            val toolbar = findViewById<Toolbar>(R.id.beagle_toolbar)
            setSupportActionBar(toolbar)
        }
        supportActionBar?.hide()

        BeagleNavigator.addScreen(this, screenUrl)
    }

    private fun buildContent(): View {
        val containerLayout = FrameLayout(this@BeagleUIActivity).apply {
            id = R.id.beagle_content
        }
        return LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            if (this@BeagleUIActivity.supportActionBar == null) {
                addView(createToolbar(), getToolbarLayoutParams())
            }
            addView(containerLayout, defaultLayoutParams)
        }
    }

    private fun getToolbarLayoutParams(): ViewGroup.LayoutParams {
        val typedValue = TypedValue()
        val actionBarHeight = if (theme.resolveAttribute(android.R.attr.actionBarSize, typedValue, true)) {
            TypedValue.complexToDimensionPixelSize(typedValue.data, resources.displayMetrics)
        } else {
            0
        }
        return ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, actionBarHeight)
    }

    private fun createToolbar(): Toolbar {
        return Toolbar(this).apply {
            id = R.id.beagle_toolbar
            visibility = View.GONE
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
