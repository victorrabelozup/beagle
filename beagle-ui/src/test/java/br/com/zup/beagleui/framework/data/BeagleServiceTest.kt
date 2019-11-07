package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.action.Action
import br.com.zup.beagleui.framework.data.deserializer.BeagleDeserializationException
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.data.deserializer.makeContainerJson
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.networking.RequestCall
import br.com.zup.beagleui.framework.networking.ResponseData
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.slot
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue

private val URL = RandomData.httpUrl()
private val JSON_SUCCESS = makeContainerJson()
private const val JSON_ERROR = ""

@ExperimentalCoroutinesApi
class BeagleServiceTest {

    private val onSuccessSlot = slot<(responseData: ResponseData) -> Unit>()
    private val onErrorSlot = slot<(throwable: Throwable) -> Unit>()

    @MockK
    private lateinit var deserialization: BeagleUiDeserialization
    @MockK
    private lateinit var httpClient: HttpClient
    @MockK
    private lateinit var widget: Widget
    @MockK
    private lateinit var action: Action
    @MockK
    private lateinit var requestCall: RequestCall
    @MockK
    private lateinit var responseData: ResponseData

    @InjectMockKs
    private lateinit var beagleService: BeagleService

    @Before
    fun setup() {
        MockKAnnotations.init(this)

        mockListenerExecution { onSuccessSlot.captured(responseData) }
        every { deserialization.deserializeWidget(any()) } returns widget
        every { deserialization.deserializeAction(any()) } returns action
        every { responseData.data } returns JSON_SUCCESS.toByteArray()
    }

    private fun mockListenerExecution(executionLambda: () -> Unit) {
        every {
            httpClient.execute(
                any(),
                onSuccess = capture(onSuccessSlot),
                onError = capture(onErrorSlot)
            )
        } answers {
            executionLambda()
            requestCall
        }
    }

    @Test
    fun fetchWidget_should_deserialize_a_widget_response() = runBlockingTest {
        val widgetResult = beagleService.fetchWidget(URL)

        verify(exactly = 1) { deserialization.deserializeWidget(JSON_SUCCESS) }
        assertEquals(widget, widgetResult)
    }

    @Test
    fun fetchWidget_should_return_a_exception_when_some_http_call_fails() = runBlockingTest {
        // Given
        val message = RandomData.string()
        val expectedException = BeagleDataException(message)
        mockListenerExecution { onErrorSlot.captured(expectedException) }

        // When
        val exceptionResponse = assertFails(message) {
            beagleService.fetchWidget(JSON_ERROR)
        }

        // Then
        assertEquals(expectedException.message, exceptionResponse.message)
    }

    @Test
    fun fetchWidget_should_return_a_exception_when_http_throws_a_exception() = runBlockingTest {
        // Given
        val exception = RuntimeException()
        every { httpClient.execute(any(), any(), any()) } throws exception

        // When
        val exceptionResponse = assertFails {
            beagleService.fetchWidget(JSON_ERROR)
        }

        // Then
        assertTrue(exceptionResponse is BeagleDataException)
    }

    @Test
    fun fetchWidget_should_return_a_exception_moshi_deserialization_fails() = runBlockingTest {
        // Given
        val exception = BeagleDeserializationException(RandomData.string())
        every { deserialization.deserializeWidget(any()) } throws exception

        // When
        val exceptionResponse = assertFails("Widget deserialization error with respective json: $JSON_ERROR") {
            beagleService.fetchWidget(JSON_ERROR)
        }

        // Then
        assertTrue(exceptionResponse is BeagleDataException)
    }

    @Test
    fun fetchAction_should_deserialize_a_action_response() = runBlockingTest {
        val actionResult = beagleService.fetchAction(URL)

        verify(exactly = 1) { deserialization.deserializeAction(JSON_SUCCESS) }
        assertEquals(action, actionResult)
    }

    @Test
    fun fetchAction_should_return_a_exception_moshi_deserialization_fails() = runBlockingTest {
        // Given
        val exception = BeagleDeserializationException(RandomData.string())
        every { deserialization.deserializeAction(any()) } throws exception

        // When
        val exceptionResponse = assertFails("Action deserialization error with respective json: $JSON_ERROR") {
            beagleService.fetchAction(JSON_ERROR)
        }

        // Then
        assertTrue(exceptionResponse is BeagleDataException)
    }
}