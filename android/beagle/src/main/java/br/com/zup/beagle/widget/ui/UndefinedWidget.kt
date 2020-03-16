package br.com.zup.beagle.widget.ui

import android.content.Context
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.ui.UndefinedViewRenderer
import br.com.zup.beagle.widget.form.InputWidget
import br.com.zup.beagle.widget.pager.PageIndicatorOutput
import br.com.zup.beagle.widget.pager.PageIndicatorComponent

internal class UndefinedWidget : InputWidget(), PageIndicatorComponent {

    override fun onErrorMessage(message: String) {}

    override fun initPageView(pageIndicatorOutput: PageIndicatorOutput) {}

    override fun onItemUpdated(newIndex: Int) {}

    override fun setCount(pages: Int) {}

    override fun getValue(): Any = ""

    override fun toView(context: Context): View = UndefinedViewRenderer(this).build(
        ActivityRootView(context as AppCompatActivity)
    )
}