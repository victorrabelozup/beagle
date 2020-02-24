package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.Menu
import android.view.MenuItem
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.content.res.ResourcesCompat
import br.com.zup.beagle.R
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.setup.DesignSystem
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.NavigationBarItem
import br.com.zup.beagle.widget.layout.ScreenComponent

internal class ScreenViewRenderer(
    override val component: ScreenComponent,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    private val actionExecutor: ActionExecutor = ActionExecutor()
) : LayoutViewRenderer<ScreenComponent>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        val flex = Flex(
            grow = 1.0,
            justifyContent = JustifyContent.SPACE_BETWEEN
        )

        addToolbarIfNecessary(rootView.getContext(), component.navigationBar)

        val container = viewFactory.makeBeagleFlexView(rootView.getContext(), flex)

        component.header?.let { header ->
            container.addServerDrivenComponent(header, rootView)
        }

        container.addServerDrivenComponent(component.content, rootView)

        component.footer?.let { footer ->
            container.addServerDrivenComponent(footer, rootView)
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
            title = navigationBar.title
            val showBackButton = navigationBar.showBackButton ?: true
            setDisplayHomeAsUpEnabled(showBackButton)
            setDisplayShowHomeEnabled(showBackButton)
            show()
        }
        context.findViewById<Toolbar>(R.id.beagle_toolbar)?.let { toolbar ->
            toolbar.visibility = View.VISIBLE
            toolbar.menu.clear()
            configToolbarStyle(context, toolbar, navigationBar.style ?: "")
            navigationBar.navigationBarItems?.let { items ->
                configToolbarItems(context, toolbar, items)
            }
        }
    }

    private fun configToolbarStyle(
        context: Context,
        toolbar: Toolbar,
        style: String
    ) {
        val designSystem = BeagleEnvironment.beagleSdk.designSystem
        if (designSystem != null) {
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

    private fun configToolbarItems(
        context: Context,
        toolbar: Toolbar,
        items: List<NavigationBarItem>
    ) {
        val designSystem = BeagleEnvironment.beagleSdk.designSystem
        for (i in items.indices) {
            toolbar.menu.add(Menu.NONE, i, Menu.NONE, items[i].text).apply {
                setOnMenuItemClickListener {
                    actionExecutor.doAction(context, items[i].action)
                    return@setOnMenuItemClickListener true
                }
                if (items[i].image == null) {
                    setShowAsAction(MenuItem.SHOW_AS_ACTION_NEVER)
                } else {
                    configMenuItem(designSystem, items, i, context)
                }
            }
        }
    }

    private fun MenuItem.configMenuItem(
        design: DesignSystem?,
        items: List<NavigationBarItem>,
        i: Int,
        context: Context
    ) {
        design?.let { designSystem ->
            items[i].image?.let { image ->
                setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS)
                icon = ResourcesCompat.getDrawable(
                    context.resources,
                    designSystem.image(image),
                    null
                )
            }
        }
    }
}
