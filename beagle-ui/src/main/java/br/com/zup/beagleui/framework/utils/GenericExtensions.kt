package br.com.zup.beagleui.framework.utils

import java.lang.reflect.ParameterizedType
import java.lang.reflect.WildcardType

fun <I, G> Any.implementsGenericTypeOf(
    interfaceClazz: Class<I>,
    genericType: Class<G>
): Boolean {
    return this::class.java.genericInterfaces.filter {
        val parameterizedType = it as ParameterizedType
        val rawType = parameterizedType.rawType as Class<*>
        rawType == interfaceClazz
    }.filterIsInstance<ParameterizedType>().any {
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