package br.com.zup.beagle.utils

import android.app.Activity
import android.content.Context
import android.content.res.Resources
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Path
import android.graphics.RectF
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.children
import androidx.core.view.size
import androidx.core.widget.TextViewCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagle.R
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.data.BeagleViewModel
import br.com.zup.beagle.engine.mapper.ViewMapper
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleButtonView
import br.com.zup.beagle.view.BeagleImageView
import br.com.zup.beagle.view.BeagleView
import br.com.zup.beagle.view.ScreenRequest
import br.com.zup.beagle.view.StateChangedListener
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image

internal var viewExtensionsViewFactory = ViewFactory()
const val FLOAT_ZERO = 0.0f

fun ViewGroup.loadView(activity: AppCompatActivity, screenRequest: ScreenRequest) {
    loadView(this, ActivityRootView(activity), screenRequest)
}

fun ViewGroup.loadView(fragment: Fragment, screenRequest: ScreenRequest) {
    loadView(this, FragmentRootView(fragment), screenRequest)
}

private fun loadView(viewGroup: ViewGroup, rootView: RootView, screenRequest: ScreenRequest) {
    viewGroup.addView(
        viewExtensionsViewFactory.makeBeagleView(viewGroup.context).apply {
            this.loadView(rootView, screenRequest)
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

internal fun BeagleButtonView.setData(widget: Button) {
    text = widget.text
    val style = widget.style ?: ""
    val designSystem = BeagleEnvironment.beagleSdk.designSystem
    val buttonStyle = designSystem?.buttonStyle(style)
    val typedArray =
        StyleManager().getTypedArray(
            context,
            designSystem?.buttonStyle(style),
            R.styleable.BeagleButtonStyle
        )
    if (buttonStyle != null && typedArray != null) {
        background = typedArray.getDrawable(R.styleable.BeagleButtonStyle_android_background)
        isAllCaps = typedArray.getBoolean(R.styleable.BeagleButtonStyle_android_textAllCaps, true)
        TextViewCompat.setTextAppearance(this, buttonStyle)
        typedArray.recycle()
    }
}

internal fun ImageView.setData(widget: Image, viewMapper: ViewMapper) {
    val contentMode = widget.contentMode ?: ImageContentMode.FIT_CENTER
    scaleType = viewMapper.toScaleType(contentMode)
    val designSystem = BeagleEnvironment.beagleSdk.designSystem
    if (designSystem != null) {
        val image = designSystem.image(widget.name)
        this.setImageResource(image)
    }
}

private fun <T> findChildViewForType(
    viewGroup: ViewGroup,
    elementList: MutableList<View>,
    type: Class<T>
) {

    if (isAssignableFrom(viewGroup, type))
        elementList.add(viewGroup)

    viewGroup.children.forEach { childView ->
        when {
            childView is ViewGroup -> findChildViewForType(childView, elementList, type)
            isAssignableFrom(childView, type) -> {
                elementList.add(childView)
            }
        }
    }
}

private fun <T> isAssignableFrom(
    viewGroup: View,
    type: Class<T>
) = viewGroup.tag != null && type.isAssignableFrom(viewGroup.tag.javaClass)

internal inline fun <reified T> ViewGroup.findChildViewForType(type: Class<T>): MutableList<View> {
    val elementList = mutableListOf<View>()

    findChildViewForType(this, elementList, type)

    return elementList
}

fun View.saveBeagleTag(tag: Any) {
    this.tag = tag
}

internal fun RootView.generateViewModelInstance(): BeagleViewModel {
    return when (this) {
        is ActivityRootView -> {
            val activity = this.activity
            ViewModelProviders.of(activity)[BeagleViewModel::class.java]
        }
        else -> {
            val fragment = (this as FragmentRootView).fragment
            ViewModelProviders.of(fragment)[BeagleViewModel::class.java]
        }
    }
}

internal fun View.applyAppearance(component: ServerDrivenComponent) {
    (component as? AppearanceComponent)?.let {
        if (it.appearance?.backgroundColor != null) {
            this.background = GradientDrawable()
            applyBackgroundColor(it)
            applyCornerRadius(it)
        } else {
            val backgroundColor: Int? = StyleManager().getBackgroundColor(
                context = context,
                component = component,
                view = this
            )

            if (backgroundColor != null) {
                this.background = GradientDrawable(
                    GradientDrawable.Orientation.TOP_BOTTOM,
                    intArrayOf(backgroundColor, backgroundColor)
                )

                applyCornerRadius(it)
            }
        }
    }
}

internal fun View.applyBackgroundColor(appearanceWidget: AppearanceComponent) {
    appearanceWidget.appearance?.backgroundColor?.let {
        (this.background as? GradientDrawable)?.setColor(it.toAndroidColor())
    }
}

internal fun String.toAndroidColor(): Int {
    val hexColor = if (this.startsWith("#")) this else "#$this"
    return Color.parseColor(hexColor)
}

internal fun View.applyCornerRadius(appearanceWidget: AppearanceComponent) {
    appearanceWidget.appearance?.cornerRadius?.let { cornerRadius ->
        if (cornerRadius.radius > FLOAT_ZERO) {
            (this as? BeagleImageView)?.cornerRadius = cornerRadius.radius.toFloat()
            (this.background as? GradientDrawable)?.cornerRadius = cornerRadius.radius.toFloat()
        }
    }
}

internal fun Canvas.applyRadius(radius: Float) {
    if (radius > FLOAT_ZERO) {
        val path = Path()
        val rect = RectF(FLOAT_ZERO, FLOAT_ZERO, this.width.toFloat(), this.height.toFloat())
        path.addRoundRect(rect, radius, radius, Path.Direction.CW)
        this.clipPath(path)
    }
}

internal fun View.applyBackgroundFromWindowBackgroundTheme(
    context: Context,
    theme: Resources.Theme?
) {
    val typedValue = TypedValue()
    theme?.resolveAttribute(android.R.attr.windowBackground, typedValue, true)
    if (typedValue.type >= TypedValue.TYPE_FIRST_COLOR_INT &&
        typedValue.type <= TypedValue.TYPE_LAST_COLOR_INT
    ) {
        setBackgroundColor(typedValue.data)
    } else {
        background = ContextCompat.getDrawable(context, typedValue.resourceId)
    }
}
