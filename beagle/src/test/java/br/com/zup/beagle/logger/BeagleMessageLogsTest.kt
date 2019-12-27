package br.com.zup.beagle.logger

import br.com.zup.beagle.mockdata.makeRequestData
import br.com.zup.beagle.mockdata.makeResponseData
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.core.Widget
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleMessageLogsTest {

    private val beagleLoggerInfoSlot = slot<String>()

    @Before
    fun setUp() {
        mockkObject(BeagleLogger)

        every { BeagleLogger.info(capture(beagleLoggerInfoSlot)) } just Runs
        every { BeagleLogger.warning(any()) } just Runs
        every { BeagleLogger.error(any()) } just Runs
        every { BeagleLogger.error(any(), any()) } just Runs
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleLogger)
    }

    @Test
    fun logHttpRequestData_should_call_BeagleLogger_info() {
        // Given
        val requestData = makeRequestData()

        // When
        BeagleMessageLogs.logHttpRequestData(requestData)

        // Then
        assertEquals("""
            *** HTTP REQUEST ***
            Endpoint=${requestData.endpoint}
            Path=${requestData.path}
            Method=${requestData.method}
            Headers=${requestData.headers}
            Body=${requestData.body}
        """.trimIndent(), beagleLoggerInfoSlot.captured)
    }

    @Test
    fun logHttpResponseData_should_call_BeagleLogger_info() {
        // Given
        val responseData = makeResponseData()

        // When
        BeagleMessageLogs.logHttpResponseData(responseData)

        // Then
        assertEquals("""
            *** HTTP RESPONSE ***
            StatusCode=${responseData.statusCode}
            Body=${String(responseData.data)}
            Headers=${responseData.headers}
        """.trimIndent(), beagleLoggerInfoSlot.captured)
    }

    @Test
    fun logUnknownHttpError_should_call_BeagleLogger_error() {
        // Given
        val throwable = mockk<Throwable>()

        // When
        BeagleMessageLogs.logUnknownHttpError(throwable)

        // Then
        verify(exactly = 1) { BeagleLogger.error("Exception thrown while trying to call http client.", throwable) }
    }

    @Test
    fun logDeserializationError_should_call_BeagleLogger_error() {
        // Given
        val json = RandomData.string()
        val exception = mockk<Exception>()

        // When
        BeagleMessageLogs.logDeserializationError(json, exception)

        // Then
        verify(exactly = 1) { BeagleLogger.error(
            "Exception thrown while trying to deserialize the following json: $json", exception) }
    }

    @Test
    fun logViewFactoryNotFoundForWidget_should_call_BeagleLogger_warning() {
        // Given
        val widget = mockk<Widget>()

        // When
        BeagleMessageLogs.logViewFactoryNotFoundForWidget(widget)

        // Then
        val message = """
            Did you miss to create a WidgetViewFactory for Widget ${widget::class.java.simpleName}
        """.trimIndent()
        verify(exactly = 1) { BeagleLogger.warning(message) }
    }

    @Test
    fun logActionBarAlreadyPresentOnView_should_call_BeagleLogger_error() {
        // Given
        val exception = mockk<Exception>()

        // When
        BeagleMessageLogs.logActionBarAlreadyPresentOnView(exception)

        // Then
        verify(exactly = 1) { BeagleLogger.error("SupportActionBar is already present", exception) }
    }

    @Test
    fun logFormValidatorNotFound_should_call_BeagleLogger_warning() {
        // Given
        val validator = RandomData.string()

        // When
        BeagleMessageLogs.logFormValidatorNotFound(validator)

        // Then
        verify(exactly = 1) { BeagleLogger.warning("Validation with name '$validator' were not found!") }
    }

    @Test
    fun logInvalidFormInputState_should_call_BeagleLogger_warning() {
        // Given
        val validator = RandomData.string()

        // When
        BeagleMessageLogs.logInvalidFormInputState(validator)

        // Then
        verify(exactly = 1) { BeagleLogger.warning("FormInput with name $validator is not valid" +
                " and does not implement a ValidationErrorListener") }
    }

    @Test
    fun logFormInputsNotFound_should_call_BeagleLogger_warning() {
        // Given
        val formActionName = RandomData.string()

        // When
        BeagleMessageLogs.logFormInputsNotFound(formActionName)

        // Then
        verify(exactly = 1) { BeagleLogger.warning("Are you missing to declare your FormInput widgets for " +
                "form action '$formActionName'?") }
    }

    @Test
    fun logFormSubmitNotFound_should_call_BeagleLogger_warning() {
        // Given
        val formActionName = RandomData.string()

        // When
        BeagleMessageLogs.logFormSubmitNotFound(formActionName)

        // Then
        verify(exactly = 1) { BeagleLogger.warning("Are you missing to declare your FormSubmit widget for " +
                "form action '$formActionName'?") }
    }
}