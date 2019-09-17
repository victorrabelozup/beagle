package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.NativeWidget

interface TextFieldValidation {
    fun type(): String
}

class EmailValidation : TextFieldValidation {
    override fun type() = "EMAIL"
}

class PhoneValidation : TextFieldValidation {
    override fun type() = "EMAIL"
}

enum class TextFieldType {
    EMAIL,
    PHONE,
    DATE,
    NUMBER,
    PASSWORD,
    TEXT
}

data class TextField(
    val id: String? = null,
    val hint: String? = null,
    val value: String? = null,
    val type: TextFieldType? = null,
    val validation: TextFieldValidation? = null
) : NativeWidget()