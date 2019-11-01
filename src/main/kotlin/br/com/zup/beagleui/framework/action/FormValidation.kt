package br.com.zup.beagleui.framework.action

data class FormValidation(
    val errors: List<FieldError>
) : Action

data class FieldError(
    val inputName: String,
    val message: String
)