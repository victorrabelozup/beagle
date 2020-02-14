package br.com.zup.beagle.compiler

import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.compiler.util.BEAGLE_CONFIG
import br.com.zup.beagle.compiler.util.error
import br.com.zup.beagle.compiler.util.implementsInterface
import com.google.auto.service.AutoService
import java.util.*
import javax.annotation.processing.AbstractProcessor
import javax.annotation.processing.ProcessingEnvironment
import javax.annotation.processing.Processor
import javax.annotation.processing.RoundEnvironment
import javax.annotation.processing.SupportedSourceVersion
import javax.lang.model.SourceVersion
import javax.lang.model.element.TypeElement

@AutoService(Processor::class)
@SupportedSourceVersion(SourceVersion.RELEASE_8)
class BeagleAnnotationProcessor : AbstractProcessor() {

    private lateinit var validatorHandlerProcessor: ValidatorHandlerProcessor
    private lateinit var beagleSetupProcessor: BeagleSetupProcessor

    override fun getSupportedAnnotationTypes(): Set<String> {
        return TreeSet(listOf(
            RegisterWidget::class.java.canonicalName,
            BeagleComponent::class.java.canonicalName,
            RegisterValidator::class.java.canonicalName
        ))
    }

    override fun init(processingEnvironment: ProcessingEnvironment) {
        super.init(processingEnvironment)

        validatorHandlerProcessor = ValidatorHandlerProcessor(processingEnvironment)
        beagleSetupProcessor = BeagleSetupProcessor(processingEnvironment)
    }

    override fun process(
        annotations: Set<TypeElement>,
        roundEnvironment: RoundEnvironment
    ): Boolean {
        if (annotations.isEmpty()) return false

        val beagleConfigElements = roundEnvironment.getElementsAnnotatedWith(
            BeagleComponent::class.java
        ).filter { element ->
            val typeElement = element as TypeElement
            typeElement.implementsInterface(BEAGLE_CONFIG.toString())
        }

        if (beagleConfigElements.size > 1) {
            processingEnv.messager.error("BeagleConfig already defined, " +
                    "remove one implementation from the application.")
        } else if (beagleConfigElements.isEmpty()) {
            processingEnv.messager.error("Did you miss to annotate your " +
                    "BeagleConfig class with @BeagleComponent?")
        } else {
            val fullClassName = beagleConfigElements[0].asType().toString()
            val beagleConfigClassName = fullClassName.substring(
                fullClassName.lastIndexOf(".") + 1
            )
            val basePackageName = fullClassName.replace(".$beagleConfigClassName", "")
            validatorHandlerProcessor.process(basePackageName, roundEnvironment)
            beagleSetupProcessor.process(basePackageName, beagleConfigClassName, roundEnvironment)
        }

        return false
    }
}