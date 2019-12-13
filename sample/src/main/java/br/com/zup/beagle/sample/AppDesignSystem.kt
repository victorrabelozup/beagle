package br.com.zup.beagle.sample

import android.app.Application
import android.util.TypedValue
import br.com.zup.beagle.setup.ButtonStyle
import br.com.zup.beagle.setup.DesignSystem

class AppDesignSystem(
    private val context: Application
) : DesignSystem {
    override fun image(name: String): Int {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun theme(): Int {
        return R.style.AppTheme
    }

    override fun textAppearance(name: String): Int {
        return when (name) {
            "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
            "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
            else -> R.style.DesignSystem_Text_Default
        }
    }

    override fun buttonStyle(name: String): ButtonStyle {
        return when (name) {
            "DesignSystem.Button.White" -> ButtonStyle(
                textAppearance = R.style.DesignSystem_Button_White,
                background = R.drawable.bg_white_button
            )
            "DesignSystem.Button.Text" -> ButtonStyle(
                textAppearance = R.style.DesignSystem_Button_Text,
                background = with(TypedValue()) {
                    context.theme.resolveAttribute(
                        android.R.attr.selectableItemBackground,
                        this,
                        true
                    )
                    resourceId
                }
            )
            else -> ButtonStyle(
                textAppearance = R.style.DesignSystem_Button_Default,
                background = R.drawable.bg_gradient_button
            )
        }
    }
}