package br.com.zup.beagleui.view

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import br.com.zup.beagleui.engine.framework.layout.Container
import com.facebook.litho.Column
import com.facebook.litho.ComponentContext
import com.facebook.litho.LithoView
import com.facebook.litho.widget.Text
import org.koin.androidx.viewmodel.ext.android.viewModel

private const val SCREEN_URL_KEY = "SCREEN_URL_KEY"

class BeagleUiActivity : AppCompatActivity() {

    private val viewModel: BeagleUiViewModel by viewModel()
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
            val context = ComponentContext(this)

            val component = Text.create(context)
                .text("Hello World")
                .textSizeDip(50.0f)
                .build()

           /* if (widget is Container) {
                widget.content
                Column.create(context)
                    .child()
            }*/

            setContentView(LithoView.create(context, component))
        })
    }

}