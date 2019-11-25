package br.com.zup.beagleui.framework.utils

import android.app.Activity
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
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
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text

internal var viewExtensionsViewFactory = ViewFactory()

fun ViewGroup.loadView(activity: AppCompatActivity, url: String) {
    this.addView(
        viewExtensionsViewFactory.makeBeagleView(this.context).apply {
            this.loadView(activity, url)
        }
    )
}

fun ViewGroup.loadView(fragment: Fragment, url: String) {
    this.addView(
        viewExtensionsViewFactory.makeBeagleView(this.context).apply {
            this.loadView(fragment, url)
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
    BeagleEnvironment.theme?.let {
        val styleRes = it.textAppearanceTheme.textAppearance(widget.style)
        TextViewCompat.setTextAppearance(this, styleRes)
    }
}

internal fun BeagleButtonView.setData(widget: Button) {
    text = widget.text
    BeagleEnvironment.theme?.let {
        val buttonAppearance = it.buttonTheme.buttonTextAppearance(widget.style)
        val buttonBackground = it.buttonTheme.buttonBackground(widget.style)

        setBackgroundResource(buttonBackground)
        TextViewCompat.setTextAppearance(this, buttonAppearance)
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