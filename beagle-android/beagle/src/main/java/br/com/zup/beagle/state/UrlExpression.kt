package br.com.zup.beagle.state

internal data class UrlExpression(
    val originalExpression: String,
    val expressionId: String,
    val expressionProperty: String
)