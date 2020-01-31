package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.R
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ScreenWidget
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.Expanded
import br.com.zup.beagle.widget.layout.NavigationBar

internal class ScreenViewRenderer(
    private val screenWidget: ScreenWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    override fun build(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0,
            flexDirection = FlexDirection.COLUMN,
            justifyContent = JustifyContent.SPACE_BETWEEN
        )

        addToolbarIfNecessary(rootView.getContext(), screenWidget.navigationBar)

        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)

        this.screenWidget.header?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        val expanded = Expanded(this.screenWidget.content)
        val contentView = viewRendererFactory.make(expanded).build(rootView)
        container.addView(contentView)

        this.screenWidget.footer?.let {
            container.addView(viewRendererFactory.make(it).build(rootView))
        }

        return container
    }

    private fun addToolbarIfNecessary(context: Context, navigationBar: NavigationBar?) {
        if (context is AppCompatActivity) {
            if (navigationBar != null) {
                configNavigationBar(context, navigationBar)
            } else {
                hideNavigationBar(context)
            }
        }
    }

    private fun hideNavigationBar(context: AppCompatActivity) {
        context.supportActionBar?.apply {
            context.findViewById<Toolbar>(R.id.beagle_toolbar)?.let {
                it.visibility = View.GONE
            }
            hide()
        }
    }

    private fun configNavigationBar(
        context: AppCompatActivity,
        navigationBar: NavigationBar
    ) {
        context.supportActionBar?.apply {
            context.findViewById<Toolbar>(R.id.beagle_toolbar)?.let {
                it.visibility = View.VISIBLE
                configToolbarStyle(context, it, navigationBar.style)
            }
            title = navigationBar.title
            val showBackButton = navigationBar.showBackButton ?: true
            setDisplayHomeAsUpEnabled(showBackButton)
            setDisplayShowHomeEnabled(showBackButton)
            show()
        }
    }

    private fun configToolbarStyle(
        context: Context,
        toolbar: Toolbar,
        style: String?
    ) {
        val designSystem = BeagleEnvironment.designSystem
        if (designSystem != null && style != null) {
            val toolbarStyle = designSystem.toolbarStyle(style)
            val typedArray = context.obtainStyledAttributes(
                toolbarStyle,
                R.styleable.BeagleToolbarStyle
            )
            toolbar.navigationIcon = typedArray.getDrawable(
                R.styleable.BeagleToolbarStyle_navigationIcon
            )
            val textAppearance = typedArray.getResourceId(
                R.styleable.BeagleToolbarStyle_titleTextAppearance, 0
            )
            if (textAppearance != 0) {
                toolbar.setTitleTextAppearance(context, textAppearance)
            }
            val backgroundColor = typedArray.getColor(
                R.styleable.BeagleToolbarStyle_android_background, 0
            )
            if (backgroundColor != 0) {
                toolbar.setBackgroundColor(backgroundColor)
            }
            typedArray.recycle()
        }
    }
}
