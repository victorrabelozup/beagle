package br.com.zup.beagleui.framework.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import br.com.zup.beagleui.framework.engine.BeagleViewBuilder
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUiActivity : AppCompatActivity() {

    private val viewModel: BeagleUiViewModel by viewModel()
    private val beagleViewBuilder: BeagleViewBuilder by inject()
    private val screenUrl: String by lazy { intent.extras?.getString(SCREEN_URL_KEY) ?: "" }

    companion object {
        fun newIntent(context: Context, url: String): Intent {
            return Intent(context, BeagleUiActivity::class.java).apply {
                putExtra(SCREEN_URL_KEY, url)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewModel.initialize(screenUrl)
        viewModel.widgetToRender.observe(this, Observer { widget ->
            setContentView(beagleViewBuilder.build(this, widget))
        })
    }
}
