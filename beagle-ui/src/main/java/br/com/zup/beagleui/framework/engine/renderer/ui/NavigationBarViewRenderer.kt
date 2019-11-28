package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.logger.BeagleLogger
import br.com.zup.beagleui.framework.utils.dp
import br.com.zup.beagleui.framework.view.BeagleNavigator
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.NavigationBar

private val WIDGET_SIZE: Int = 24.dp()
private val MARGIN_BORDER: Int = 16.dp()
private val MARGIN_WIDGET: Int = 32.dp()
private val MARGIN_TITLE: Int = 72.dp()

internal class NavigationBarViewRenderer(
    private val navBar: NavigationBar,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val viewRendererFactory: ViewRendererFactory = ViewRendererFactory()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makeFrameLayout(rootView.getContext()).apply {
            navBar.leading?.let {
                addView(navBar.leading?.let {
                    viewRendererFactory.make(it).build(rootView)
                }, getNavigationBarWidgetParams(Gravity.START, MARGIN_BORDER, MARGIN_WIDGET))
            }
            buildToolbar(this, rootView.getContext())
            navBar.trailing?.let {
                addView(navBar.trailing?.let {
                    viewRendererFactory.make(it).build(rootView)
                }, getNavigationBarWidgetParams(Gravity.END, 0, MARGIN_BORDER))
            }
        }
    }

    private fun getNavigationBarWidgetParams(
        gravity: Int,
        marginStart: Int,
        marginEnd: Int
    ): FrameLayout.LayoutParams {
        val widgetLayoutParams = viewFactory.makeFrameLayoutParams(WIDGET_SIZE, WIDGET_SIZE)
        widgetLayoutParams.gravity = gravity or Gravity.CENTER_VERTICAL
        widgetLayoutParams.marginStart = marginStart
        widgetLayoutParams.marginEnd = marginEnd
        return widgetLayoutParams
    }

    private fun buildToolbar(frameLayout: FrameLayout, context: Context) {
        frameLayout.addView(viewFactory.makeNavigationBar(context).apply {
            title = navBar.title
            if (navBar.leading == null) {
                buildBackButton(context, this)
            } else {
                titleMarginStart = MARGIN_TITLE
            }
        })
    }

    private fun buildBackButton(context: Context, toolbar: Toolbar) {
        if (context is AppCompatActivity) {
            try {
                context.setSupportActionBar(toolbar)
                context.supportActionBar?.setDisplayHomeAsUpEnabled(true)
                context.supportActionBar?.setDisplayShowHomeEnabled(true)
            } catch (e: IllegalStateException) {
                BeagleLogger.warning("SupportActionBar is already present: " + e.message)
            }
        }
        toolbar.setNavigationOnClickListener {
            BeagleNavigator.pop(context)
        }
    }
}