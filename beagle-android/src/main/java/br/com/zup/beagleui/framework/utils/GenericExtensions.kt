package br.com.zup.beagleui.framework.utils

import androidx.core.util.PatternsCompat
import br.com.zup.beagleui.framework.state.UrlExpression
import java.lang.reflect.ParameterizedType
import java.lang.reflect.WildcardType
private const val REGEX_EXPRESSION = "#\\{[^\\}]*\\}"

fun <I, G> Any.implementsGenericTypeOf(
    interfaceClazz: Class<I>,
    genericType: Class<G>
): Boolean {
    return this::class.java.genericInterfaces.filterIsInstance<ParameterizedType>()
        .filter {
            val rawType = it.rawType as Class<*>
            rawType == interfaceClazz
        }.any {
            val types = it.actualTypeArguments
            val paramType = types[0]
            val type = if (paramType is WildcardType) {
                paramType.upperBounds[0]
            } else {
                paramType
            }
            val typeClass = type as Class<*>
            genericType == typeClass
        }
}

fun String.isValidUrl(): Boolean = PatternsCompat.WEB_URL.matcher(this).matches()

internal fun String.findUrlExpressions(): MutableList<UrlExpression> {
    val mutableList = mutableListOf<UrlExpression>()

    val regex = REGEX_EXPRESSION.toRegex()
    val expressionFound = regex.findAll(this).forEach {
        mutableList.add(UrlExpression(
            originalExpression = it.value,
            expressionId = getExpressionId(it.value),
            expressionProperty = getExpressionProperty(it.value))
        )
    }
    return mutableList
}

private fun removeExpressionCharacters(it: String) = it.replace("#", "")
    .replace("{", "").replace("}", "").trim()

private fun getExpressionId(originalExpression: String): String {

    return removeExpressionCharacters(originalExpression).split(".").first()
}

private fun getExpressionProperty(originalExpression: String): String {
    return removeExpressionCharacters(originalExpression).split(".").last()
}