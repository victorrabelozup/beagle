package br.com.zup.beagle.widget.core

data class Appearance(val backgroundColor: String? = null,
                      val cornerRadius: CornerRadius? = null)

data class CornerRadius(
    val radius: Double = 0.0
)