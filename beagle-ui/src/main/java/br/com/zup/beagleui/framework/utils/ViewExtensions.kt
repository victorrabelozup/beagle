package br.com.zup.beagleui.framework.utils

import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import androidx.core.view.size
import androidx.fragment.app.Fragment
import br.com.zup.beagleui.framework.view.BeagleView
import br.com.zup.beagleui.framework.view.StateChangedListener
import br.com.zup.beagleui.framework.view.ViewFactory
import android.app.Activity
import android.view.View
import android.view.inputmethod.InputMethodManager

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