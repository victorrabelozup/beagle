package br.com.zup.beagleui.framework.utils

import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import androidx.core.view.size
import androidx.core.widget.TextViewCompat
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.BeagleButtonView
import br.com.zup.beagleui.framework.view.BeagleTextView
import br.com.zup.beagleui.framework.view.BeagleView
import br.com.zup.beagleui.framework.view.StateChangedListener
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import android.app.Activity
import android.view.View
import android.view.inputmethod.InputMethodManager
import br.com.zup.beagleui.framework.engine.renderer.ActivityRootView
import br.com.zup.beagleui.framework.engine.renderer.FragmentRootView
import br.com.zup.beagleui.framework.engine.renderer.RootView

internal var viewExtensionsViewFactory = ViewFactory()

fun ViewGroup.loadView(activity: AppCompatActivity, url: String) {
    loadView(this, ActivityRootView(activity), url)
}

fun ViewGroup.loadView(fragment: Fragment, url: String) {
    loadView(this, FragmentRootView(fragment), url)
}

private fun loadView(viewGroup: ViewGroup, rootView: RootView, url: String) {
    viewGroup.addView(
        viewExtensionsViewFactory.makeBeagleView(viewGroup.context).apply {
            this.loadView(rootView, url)
        }
    )
}

fun ViewGroup.setBeagleStateChangedListener(listener: StateChangedListener) {
    check(size != 0) { "Did you miss to call loadView()?" }

    val view = children.find { it is BeagleView } as? BeagleView

    if (view != null) {
        view.stateChangedListener = listener
    } else {
        throw IllegalStateException("Did you miss to call loadView()?")
    }
}

internal fun View.hideKeyboard() {
    val activity = context as AppCompatActivity
    val view = activity.currentFocus ?: viewExtensionsViewFactory.makeView(activity)
    val imm = activity.getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
    imm.hideSoftInputFromWindow(view.windowToken, 0)
}

internal fun BeagleTextView.setData(widget: Text) {
    this.text = widget.text
    val style = widget.style ?: ""
    val designSystem = BeagleEnvironment.designSystem
    if (designSystem != null) {
        val styleRes = designSystem.textAppearance(style)
        TextViewCompat.setTextAppearance(this, styleRes)
    }
}

internal fun BeagleButtonView.setData(widget: Button) {
    text = widget.text
    val style = widget.style ?: ""
    val designSystem = BeagleEnvironment.designSystem
    if (designSystem != null) {
        val buttonStyle = designSystem.buttonStyle(style)
        setBackgroundResource(buttonStyle.background)
        TextViewCompat.setTextAppearance(this, buttonStyle.textAppearance)
    }
}

private fun <T> findChildViewForType(
    viewGroup: ViewGroup,
    elementList: MutableList<View>,
    type: Class<T>
) {
    viewGroup.children.forEach { childView ->
        when {
            childView is ViewGroup -> findChildViewForType(childView, elementList, type)
            childView.tag != null && type.isAssignableFrom(childView.tag.javaClass) -> {
                elementList.add(childView)
            }
        }
    }
}

internal inline fun <reified T> ViewGroup.findChildViewForType(type: Class<T>): MutableList<View> {
    val elementList = mutableListOf<View>()

    findChildViewForType(this, elementList, type)

    return elementList
}

internal fun List<View>.findChildViewForUpdatableWidgetId(
    widgetId: String
): View? {
    return this.find { child ->
        (child.tag as UpdatableWidget).id == widgetId
    }
}