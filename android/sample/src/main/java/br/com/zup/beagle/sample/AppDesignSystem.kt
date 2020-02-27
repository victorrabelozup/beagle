package br.com.zup.beagle.sample
import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.setup.DesignSystem

@BeagleComponent
class AppDesignSystem : DesignSystem {

    override fun toolbarStyle(name: String): Int {
        return R.style.DesignSystem_Toolbar
    }

    override fun image(name: String): Int {
        return when (name) {
            "delete" -> android.R.drawable.ic_delete
            "TestImage" -> android.R.drawable.editbox_dropdown_dark_frame
            else -> android.R.drawable.ic_menu_help
        }
    }

    override fun theme(): Int {
        return R.style.AppTheme_NoToolbar
    }

    override fun textAppearance(name: String): Int {
        return when (name) {
            "DesignSystem.Text.H2" -> R.style.DesignSystem_Text_H2
            "DesignSystem.Text.H3" -> R.style.DesignSystem_Text_H3
            else -> R.style.DesignSystem_Text_Default
        }
    }

    override fun buttonStyle(name: String): Int {
        return when (name) {
            "DesignSystem.Button.White" -> R.style.DesignSystem_Button_White
            "DesignSystem.Button.Text" -> R.style.DesignSystem_Button_Text
            "DesignSystem.Button.Black" -> R.style.DesignSystem_Button_Black
            else -> R.style.DesignSystem_Button_Default
        }
    }
}