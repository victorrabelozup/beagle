package br.com.zup.beagle.utils

import android.app.Activity
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Path
import android.graphics.RectF
import android.graphics.drawable.Drawable
import android.graphics.drawable.GradientDrawable
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import androidx.core.view.size
import androidx.core.widget.TextViewCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import br.com.zup.beagle.R
import br.com.zup.beagle.data.BeagleViewModel
import br.com.zup.beagle.engine.mapper.ViewMapper
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleButtonView
import br.com.zup.beagle.view.BeagleTextView
import br.com.zup.beagle.view.BeagleView
import br.com.zup.beagle.view.StateChangedListener
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.ImageContentMode
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.Text
import br.com.zup.beagle.widget.ui.TextAlignment

internal var viewExtensionsViewFactory = ViewFactory()
const val FLOAT_ZERO = 0.0f

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
    when (widget.alignment) {
        TextAlignment.CENTER -> this.gravity = Gravity.CENTER
        TextAlignment.RIGHT -> this.gravity = Gravity.END
        else -> this.gravity = Gravity.START
    }
}

internal fun BeagleButtonView.setData(widget: Button) {
    text = widget.text
    val style = widget.style ?: ""
    val designSystem = BeagleEnvironment.designSystem
    if (designSystem != null) {
        val buttonStyle = designSystem.buttonStyle(style)
        val typedArray = context.obtainStyledAttributes(buttonStyle, R.styleable.BeagleButtonStyle)
        setBackground(typedArray.getDrawable(R.styleable.BeagleButtonStyle_android_background))
        typedArray.recycle()
        TextViewCompat.setTextAppearance(this, buttonStyle)
    }
}

internal fun ImageView.setData(widget: Image, viewMapper: ViewMapper) {
    val contentMode = widget.contentMode ?: ImageContentMode.FIT_CENTER
    scaleType = viewMapper.toScaleType(contentMode)
    val designSystem = BeagleEnvironment.designSystem
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

internal fun List<View>.findChildViewForUpdatableWidgetId(
    widgetId: String
): View? {
    return this.find { child ->
        (child.tag as UpdatableWidget).id == widgetId
    }
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

internal fun View.applyAppearance(widget: Widget) {
    (widget as? AppearanceWidget)?.let {
        this.background = GradientDrawable()
        applyBackgroundColor(it)
        applyCornerRadius(it)
    }
}

internal fun View.applyBackgroundColor(appearanceWidget: AppearanceWidget) {
    appearanceWidget.appearance?.backgroundColor?.let {
        (this.background as? GradientDrawable)?.setColor(Color.parseColor(it))
    }
}

internal fun View.applyCornerRadius(appearanceWidget: AppearanceWidget) {
    appearanceWidget.appearance?.cornerRadius?.let { cornerRadius ->
        if (cornerRadius.radius > FLOAT_ZERO) {
            (this.background as? GradientDrawable)?.cornerRadius = cornerRadius.radius.toFloat()
        }
    }
}

internal fun Drawable.getGradientDrawableRadius(): Float {
    try {
        if (this is GradientDrawable) {
            val mGradientStateField =
                this.javaClass.getDeclaredField("mGradientState")
            mGradientStateField.setNotFinalAndAccessible()
            val gradientState = mGradientStateField.get(this)
            val mRadiusField = gradientState.javaClass.getDeclaredField("mRadius")
            mRadiusField.setNotFinalAndAccessible()
            return mRadiusField.get(gradientState) as Float
        }
    } catch (e: Throwable) {
        BeagleLogger.warning("Could not get corner radius, returning $FLOAT_ZERO")
    }

    return FLOAT_ZERO
}

internal fun Canvas.applyRadius(radius: Float) {
    if (radius > FLOAT_ZERO) {
        val path = Path()
        val rect = RectF(FLOAT_ZERO, FLOAT_ZERO, this.width.toFloat(), this.height.toFloat())
        path.addRoundRect(rect, radius, radius, Path.Direction.CW)
        this.clipPath(path)
    }
}