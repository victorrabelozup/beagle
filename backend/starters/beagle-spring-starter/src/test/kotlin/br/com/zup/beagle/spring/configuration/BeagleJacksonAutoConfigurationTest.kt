package br.com.zup.beagle.spring.configuration

import br.com.zup.beagle.serialization.jackson.BeagleSerializationUtil
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.boot.autoconfigure.AutoConfigurations
import org.springframework.boot.test.context.FilteredClassLoader
import org.springframework.boot.test.context.runner.ApplicationContextRunner
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import kotlin.reflect.KClass
import kotlin.test.assertEquals
import kotlin.test.assertTrue

internal class BeagleJacksonAutoConfigurationTest {
    private val contextRunner by lazy {
        ApplicationContextRunner().withConfiguration(AutoConfigurations.of(BeagleJacksonAutoConfiguration::class.java))
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_is_in_context() {
        testApplicationContext("objectMapper")
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_is_not_in_context_without_BeagleSerializationUtil() {
        contextRunner.withClassLoader(FilteredClassLoader(BeagleSerializationUtil::class.java))
            .run { assertThat(it).doesNotHaveBean(ObjectMapper::class.java) }
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_objectMapper_is_overridden_by_user_configuration() {
        testApplicationContext(
            beanName = "mapper",
            userConfiguration = MyJacksonConfiguration::class,
            inclusion = JsonInclude.Include.USE_DEFAULTS,
            features = emptyList()
        )
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_with_include_property() {
        val inclusion = JsonInclude.Include.NON_EMPTY
        testApplicationContext(
            beanName = "objectMapper",
            inclusion = inclusion,
            properties = arrayOf("beagle.serialization.include=$inclusion")
        )
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_with_invalid_include_property() {
        testApplicationContextFailure("beagle.serialization.include=-")
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_with_features_property() {
        val features = listOf(SerializationFeature.CLOSE_CLOSEABLE, SerializationFeature.FLUSH_AFTER_WRITE_VALUE)
        testApplicationContext(
            beanName = "objectMapper",
            features = features,
            properties = arrayOf("beagle.serialization.features=${features.joinToString()}")
        )
    }

    @Test
    fun test_BeagleJacksonAutoConfiguration_with_invalid_features_property() {
        testApplicationContextFailure("beagle.serialization.features=-")
    }

    private fun testApplicationContext(
        beanName: String,
        userConfiguration: KClass<*> = MyConfiguration::class,
        inclusion: JsonInclude.Include = JsonInclude.Include.NON_NULL,
        features: List<SerializationFeature> = listOf(SerializationFeature.INDENT_OUTPUT),
        properties: Array<String> = emptyArray()
    ) =
        contextRunner.withUserConfiguration(userConfiguration.java).withPropertyValues(*properties)
            .run { context ->
                val objectMapper = context.getBean(ObjectMapper::class.java)
                assertThat(context).hasSingleBean(ObjectMapper::class.java)
                assertThat(context).getBean(beanName).isEqualTo(objectMapper)
                assertEquals(inclusion, objectMapper.serializationConfig.defaultPropertyInclusion.valueInclusion)
                assertTrue { features.all { it.enabledIn(objectMapper.serializationConfig.serializationFeatures) } }
            }

    private fun testApplicationContextFailure(property: String) {
        contextRunner.withPropertyValues(property).run { assertThat(it).hasFailed() }
    }

    @Configuration
    private open class MyConfiguration

    @Configuration
    private open class MyJacksonConfiguration {
        @Bean
        open fun mapper() = BeagleSerializationUtil.beagleObjectMapper()
    }
}