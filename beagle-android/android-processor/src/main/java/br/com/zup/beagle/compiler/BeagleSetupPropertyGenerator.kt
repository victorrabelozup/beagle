package br.com.zup.beagle.compiler

import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.compiler.util.BeagleClass
import br.com.zup.beagle.compiler.util.CUSTOM_ACTION_HANDLER
import br.com.zup.beagle.compiler.util.DEEP_LINK_HANDLER
import br.com.zup.beagle.compiler.util.DESIGN_SYSTEM
import br.com.zup.beagle.compiler.util.HTTP_CLIENT_HANDLER
import br.com.zup.beagle.compiler.util.VALIDATOR_HANDLER
import br.com.zup.beagle.compiler.util.error
import br.com.zup.beagle.compiler.util.implementsInterface
import com.squareup.kotlinpoet.ClassName
import com.squareup.kotlinpoet.KModifier
import com.squareup.kotlinpoet.PropertySpec
import javax.annotation.processing.ProcessingEnvironment
import javax.annotation.processing.RoundEnvironment
import javax.lang.model.element.TypeElement

class BeagleSetupPropertyGenerator(private val processingEnv: ProcessingEnvironment) {

    fun generate(
        basePackageName: String,
        roundEnvironment: RoundEnvironment
    ): List<PropertySpec> {
        var deepLinkHandler: TypeElement? = null
        var customActionHandler: TypeElement? = null
        var httpClient: TypeElement? = null
        var designSystem: TypeElement? = null

        roundEnvironment.getElementsAnnotatedWith(BeagleComponent::class.java).forEach { element ->
            val typeElement = element as TypeElement

            when {
                typeElement.implementsInterface(CUSTOM_ACTION_HANDLER.toString()) -> {
                    if (customActionHandler == null) {
                        customActionHandler = typeElement
                    } else {
                        processingEnv.messager.error(typeElement, "CustomActionHandler already " +
                                "defined, remove one implementation from the application.")
                    }
                }
                typeElement.implementsInterface(DEEP_LINK_HANDLER.toString()) -> {
                    if (deepLinkHandler == null) {
                        deepLinkHandler = typeElement
                    } else {
                        processingEnv.messager.error(typeElement, "DeepLinkHandler already " +
                                "defined, remove one implementation from the application.")
                    }
                }
                typeElement.implementsInterface(HTTP_CLIENT_HANDLER.toString()) -> {
                    if (httpClient == null) {
                        httpClient = typeElement
                    } else {
                        processingEnv.messager.error(typeElement, "HttpClient already defined, " +
                                "remove one implementation from the application.")
                    }
                }
                typeElement.implementsInterface(DESIGN_SYSTEM.toString()) -> {
                    if (designSystem == null) {
                        designSystem = typeElement
                    } else {
                        processingEnv.messager.error(typeElement, "DesignSystem already defined, " +
                                "remove one implementation from the application.")
                    }
                }
            }
        }

        return createListOfPropertySpec(
            basePackageName,
            deepLinkHandler,
            customActionHandler,
            httpClient,
            designSystem
        )
    }

    private fun createListOfPropertySpec(
        basePackageName: String,
        deepLinkHandler: TypeElement? = null,
        customActionHandler: TypeElement? = null,
        httpClient: TypeElement? = null,
        designSystem: TypeElement? = null
    ): List<PropertySpec> {
        return listOf(
            implementProperty(
                customActionHandler.toString(),
                "customActionHandler",
                CUSTOM_ACTION_HANDLER
            ),
            implementProperty(
                deepLinkHandler.toString(),
                "deepLinkHandler",
                DEEP_LINK_HANDLER
            ),
            implementProperty(
                httpClient.toString(),
                "httpClient",
                HTTP_CLIENT_HANDLER
            ),
            implementProperty(
                designSystem.toString(),
                "designSystem",
                DESIGN_SYSTEM
            ),
            implementProperty(
                "$basePackageName.$VALIDATOR_HANDLER_IMPL_NAME",
                "validatorHandler",
                VALIDATOR_HANDLER
            )
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
}