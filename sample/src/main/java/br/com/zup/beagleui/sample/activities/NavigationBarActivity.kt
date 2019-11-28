package br.com.zup.beagleui.sample.activities

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagleui.framework.utils.toView
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.JustifyContent
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.FlexWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.NavigationBar
import br.com.zup.beagleui.sample.widgets.TextField

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
        val declarative = Container(
            content = FlexWidget(
                flex = Flex(justifyContent = JustifyContent.CENTER),
                children = listOf(
                    NavigationBar(
                        title = "Navigation Bar",
                        trailing = Button(text = "B")
                    ),
                    TextField(
                        hint = "this hint",
                        color = "#FFFFFF"
                    )
                )
            )
        )
        return declarative.toView(this)
    }
}