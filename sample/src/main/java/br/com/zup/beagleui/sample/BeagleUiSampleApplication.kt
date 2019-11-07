package br.com.zup.beagleui.sample

import android.app.Application
import android.content.Context
import android.util.TypedValue
import br.com.zup.beagleui.framework.action.CustomAction
import br.com.zup.beagleui.framework.action.CustomActionHandler
import br.com.zup.beagleui.framework.setup.BeagleInitializer
import br.com.zup.beagleui.framework.setup.ButtonTheme
import br.com.zup.beagleui.framework.setup.TextAppearanceTheme
import br.com.zup.beagleui.framework.setup.Theme

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleInitializer
            .registerTheme(Theme(AppButtonTheme(this), AppTextAppearanceTheme()))
            .registerCustomActionHandler(AppCustomActionHandler())
            .setup("sample", this)
    }
}

class AppCustomActionHandler : CustomActionHandler {
    override fun handle(context: Context, action: CustomAction) {
        print("Custom Action executed")
    }
}

class AppButtonTheme(
    private val context: Application
) : ButtonTheme {
    override fun buttonTextAppearance(style: String?): Int {
        return when (style) {
            "DesignSystem.Button.White" -> R.style.DesignSystem_Button_White
            "DesignSystem.Button.Text" -> R.style.DesignSystem_Button_Text
            else -> R.style.DesignSystem_Button_Default
        }
    }

    override fun buttonBackground(style: String?): Int {
        return when (style) {
            "DesignSystem.Button.White" -> R.drawable.bg_white_button
            "DesignSystem.Button.Text" -> with(TypedValue()) {
                context.theme.resolveAttribute(
                    android.R.attr.selectableItemBackground,
                    this,
                    true
                )
                resourceId
            }
            else -> R.drawable.bg_gradient_button
        }
    }
}

class AppTextAppearanceTheme : TextAppearanceTheme {
    override fun textAppearance(style: String?): Int {
        return when (style) {
            "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
            "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
            else -> R.style.DesignSystem_Text_Default
        }
    }
}