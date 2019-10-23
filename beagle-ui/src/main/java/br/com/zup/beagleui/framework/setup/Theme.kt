package br.com.zup.beagleui.framework.setup

data class Theme(
    val buttonTheme: ButtonTheme,
    val textAppearanceTheme: TextAppearanceTheme
)

interface ButtonTheme {
    fun buttonTextAppearance(style: String? = ""): Int
    fun buttonBackground(style: String? = ""): Int
}

interface TextAppearanceTheme {
    fun textAppearance(style: String? = ""): Int

}