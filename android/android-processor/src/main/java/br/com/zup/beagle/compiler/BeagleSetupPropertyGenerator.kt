/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.compiler

import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.compiler.util.ANALYTICS
import br.com.zup.beagle.compiler.util.BEAGLE_ACTIVITY
import br.com.zup.beagle.compiler.util.BeagleClass
import br.com.zup.beagle.compiler.util.CUSTOM_ACTION_HANDLER
import br.com.zup.beagle.compiler.util.DEEP_LINK_HANDLER
import br.com.zup.beagle.compiler.util.DESIGN_SYSTEM
import br.com.zup.beagle.compiler.util.HTTP_CLIENT_HANDLER
import br.com.zup.beagle.compiler.util.URL_BUILDER_HANDLER
import br.com.zup.beagle.compiler.util.VALIDATOR_HANDLER
import br.com.zup.beagle.compiler.util.error
import br.com.zup.beagle.compiler.util.extendsFromClass
import br.com.zup.beagle.compiler.util.implementsInterface
import com.squareup.kotlinpoet.ClassName
import com.squareup.kotlinpoet.KModifier
import com.squareup.kotlinpoet.ParameterizedTypeName.Companion.parameterizedBy
import com.squareup.kotlinpoet.PropertySpec
import com.squareup.kotlinpoet.asClassName
import javax.annotation.processing.ProcessingEnvironment
import javax.annotation.processing.RoundEnvironment
import javax.lang.model.element.TypeElement

class BeagleSetupPropertyGenerator(private val processingEnv: ProcessingEnvironment) {

    fun generate(
        basePackageName: String,
        roundEnvironment: RoundEnvironment
    ): List<PropertySpec> {
        var propertySpecifications: PropertySpecifications? = PropertySpecifications()

        roundEnvironment.getElementsAnnotatedWith(BeagleComponent::class.java).forEach { element ->
            val typeElement = element as TypeElement

            when {
                typeElement.implementsInterface(CUSTOM_ACTION_HANDLER.toString()) -> {
                    if (propertySpecifications?.customActionHandler == null) {
                        propertySpecifications?.customActionHandler = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "CustomActionHandler")
                    }
                }
                typeElement.implementsInterface(DEEP_LINK_HANDLER.toString()) -> {
                    if (propertySpecifications?.deepLinkHandler == null) {
                        propertySpecifications?.deepLinkHandler = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "DeepLinkHandler")
                    }
                }
                typeElement.implementsInterface(HTTP_CLIENT_HANDLER.toString()) -> {
                    if (propertySpecifications?.httpClient == null) {
                        propertySpecifications?.httpClient = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "HttpClient")
                    }
                }
                typeElement.implementsInterface(DESIGN_SYSTEM.toString()) -> {
                    if (propertySpecifications?.designSystem == null) {
                        propertySpecifications?.designSystem = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "DesignSystem")
                    }
                }
                typeElement.extendsFromClass(BEAGLE_ACTIVITY.toString()) -> {
                    if (propertySpecifications?.beagleActivity == null) {
                        propertySpecifications?.beagleActivity = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "BeagleActivity")
                    }
                }
                typeElement.implementsInterface(URL_BUILDER_HANDLER.toString()) -> {
                    if (propertySpecifications?.urlBuilder == null) {
                        propertySpecifications?.urlBuilder = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "UrlBuilder")
                    }
                }
                typeElement.implementsInterface(ANALYTICS.toString()) -> {
                    if (propertySpecifications?.analytics == null) {
                        propertySpecifications?.analytics = typeElement
                    } else {
                        logImplementationErrorMessage(typeElement, "Analytics")
                    }
                }
            }
        }

        if (propertySpecifications?.beagleActivity == null) {
            processingEnv.messager.error("BeagleActivity were not defined. " +
                "Did you miss to create your own Activity that extends from BeagleActivity " +
                "and annotate it with @BeagleComponent?")
        }

        return createListOfPropertySpec(
            basePackageName,
            propertySpecifications
        )
    }

    private fun logImplementationErrorMessage(typeElement: TypeElement, element: String) {
        processingEnv.messager.error(typeElement, "${element} already " +
            "defined, remove one implementation from the application.")
    }

    private fun createListOfPropertySpec(
        basePackageName: String,
        propertySpecifications: PropertySpecifications?
    ): List<PropertySpec> {
        return listOf(
            implementProperty(
                propertySpecifications?.customActionHandler.toString(),
                "customActionHandler",
                CUSTOM_ACTION_HANDLER
            ),
            implementProperty(
                propertySpecifications?.deepLinkHandler.toString(),
                "deepLinkHandler",
                DEEP_LINK_HANDLER
            ),
            implementProperty(
                propertySpecifications?.httpClient.toString(),
                "httpClient",
                HTTP_CLIENT_HANDLER
            ),
            implementProperty(
                propertySpecifications?.designSystem.toString(),
                "designSystem",
                DESIGN_SYSTEM
            ),
            implementProperty(
                "$basePackageName.$VALIDATOR_HANDLER_IMPL_NAME",
                "validatorHandler",
                VALIDATOR_HANDLER
            ),
            implementProperty(
                propertySpecifications?.urlBuilder.toString(),
                "urlBuilder",
                URL_BUILDER_HANDLER
            ),
            implementProperty(
                propertySpecifications?.analytics.toString(),
                "analytics",
                ANALYTICS
            ),
            implementServerDrivenActivityProperty(propertySpecifications?.beagleActivity)
        )
    }

    private fun implementProperty(
        propertyValue: String,
        propertyName: String,
        propertyType: BeagleClass
    ): PropertySpec {

        val propertyValueIsNull = propertyValue == "null"
        val property = PropertySpec.builder(
            propertyName,
            ClassName(
                propertyType.packageName,
                propertyType.className
            ).copy(nullable = propertyValueIsNull),
            KModifier.OVERRIDE
        )

        val value = if (propertyValueIsNull) {
            propertyValue
        } else {
            "$propertyValue()"
        }

        property.initializer(value)

        return property.build()
    }

    private fun implementServerDrivenActivityProperty(typeElement: TypeElement?): PropertySpec {
        return PropertySpec.builder(
            "serverDrivenActivity",
            Class::class.asClassName().parameterizedBy(
                ClassName(BEAGLE_ACTIVITY.packageName, BEAGLE_ACTIVITY.className)
            ),
            KModifier.OVERRIDE
        ).initializer("$typeElement::class.java as Class<BeagleActivity>").build()
    }
}

internal class PropertySpecifications(
    var deepLinkHandler: TypeElement? = null,
    var customActionHandler: TypeElement? = null,
    var httpClient: TypeElement? = null,
    var designSystem: TypeElement? = null,
    var beagleActivity: TypeElement? = null,
    var urlBuilder: TypeElement? = null,
    var analytics: TypeElement? = null
)
