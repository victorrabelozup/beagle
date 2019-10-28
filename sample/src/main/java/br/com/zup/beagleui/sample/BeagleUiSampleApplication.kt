package br.com.zup.beagleui.sample

import android.app.Application
import android.util.TypedValue
import br.com.zup.beagleui.framework.setup.BeagleInitializer
import br.com.zup.beagleui.framework.setup.ButtonTheme
import br.com.zup.beagleui.framework.setup.TextAppearanceTheme
import br.com.zup.beagleui.framework.setup.Theme

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleInitializer
            .registerTheme(Theme(buttonTheme = object : ButtonTheme {
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
                            theme.resolveAttribute(
                                android.R.attr.selectableItemBackground,
                                this,
                                true
                            )
                            resourceId
                        }
                        else -> R.drawable.bg_gradient_button
                    }
                }

            }, textAppearanceTheme = object : TextAppearanceTheme {
                override fun textAppearance(style: String?): Int {
                    return when (style) {
                        "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
                        "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
                        else -> R.style.DesignSystem_Text_Default
                    }
                }

            }))
            .setup("sample", this)
    }
}
