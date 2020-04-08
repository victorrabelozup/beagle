/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.compiler

import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.compiler.util.WIDGET_VIEW
import com.squareup.kotlinpoet.ClassName
import com.squareup.kotlinpoet.FunSpec
import com.squareup.kotlinpoet.KModifier
import com.squareup.kotlinpoet.ParameterizedTypeName.Companion.parameterizedBy
import com.squareup.kotlinpoet.asClassName
import javax.annotation.processing.RoundEnvironment

class BeagleSetupRegisteredWidgetGenerator {

    fun generate(roundEnvironment: RoundEnvironment): FunSpec {
        val classValues = StringBuilder()
        val registerWidgetAnnotatedClasses = roundEnvironment.getElementsAnnotatedWith(RegisterWidget::class.java)
        val listReturnType = List::class.asClassName().parameterizedBy(
            Class::class.asClassName().parameterizedBy(
                ClassName(WIDGET_VIEW.packageName, WIDGET_VIEW.className)
            )
        )

        registerWidgetAnnotatedClasses.forEachIndexed { index, element ->
            classValues.append("\t$element::class.java as Class<WidgetView>")
            if (index < registerWidgetAnnotatedClasses.size - 1) {
                classValues.append(",\n")
            }
        }

        return FunSpec.builder("registeredWidgets")
            .addModifiers(KModifier.OVERRIDE)
            .returns(listReturnType)
            .addCode("""
                        |val registeredWidgets = listOf<Class<WidgetView>>(
                        |   $classValues
                        |)
                    |""".trimMargin())
            .addStatement("return registeredWidgets")
            .build()
    }
}