package br.com.zup.beagle.sample.activities

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagle.sample.widgets.TextField
import br.com.zup.beagle.utils.toView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen

class NavigationBarActivity : AppCompatActivity() {
    companion object {
        fun newIntent(context: Context): Intent {
            return Intent(context, NavigationBarActivity::class.java)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(buildContent())
    }

    private fun buildContent(): View {
        val declarative = Screen(
            navigationBar = NavigationBar(
                title = "Sample Title",
                showBackButton = true,
                style = "toolbar"
            ),
            content = Container(
                children = listOf(
                    TextField(
                        hint = "this hint",
                        color = "#FFFFFF"
                    )
                )
            ).applyFlex(Flex(justifyContent = JustifyContent.CENTER))
        )
        return declarative.toView(this)
    }
}